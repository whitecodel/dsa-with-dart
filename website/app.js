const express = require("express");
const fs = require("fs").promises;
const path = require("path");
const { marked } = require("marked");
const hljs = require("highlight.js");
const mongoose = require("mongoose");
const session = require("express-session");
const MongoStore = require("connect-mongo");
const passport = require("passport");
const dotenv = require("dotenv");
const bodyParser = require("body-parser"); // Add this line

// Load environment variables
dotenv.config();

// Load passport config
require("./config/passport");

const app = express();
const PORT = process.env.PORT || 7676;

// MongoDB Connection
const MONGO_URI =
  process.env.MONGO_URI || "mongodb://localhost:27017/dsa-with-dart";
mongoose
  .connect(MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch((err) => {
    console.error("MongoDB connection error:", err);
    process.exit(1);
  });

// Set view engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Add body parser middleware for JSON
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Session middleware
app.use(
  session({
    secret: process.env.SESSION_SECRET || "keyboard cat",
    resave: false,
    saveUninitialized: false,
    store: MongoStore.create({ mongoUrl: MONGO_URI }),
    cookie: {
      secure: process.env.NODE_ENV === "production",
      maxAge: 24 * 60 * 60 * 1000, // 1 day
    },
  })
);

// Passport middleware
app.use(passport.initialize());
app.use(passport.session());

// Set global user variable for templates
app.use((req, res, next) => {
  res.locals.user = req.user || null;
  next();
});

// Serve static files
app.use(express.static(path.join(__dirname, "public")));

// Import route files
const authRoutes = require("./routes/auth");
const quizRoutes = require("./routes/quiz"); // Add this line

// Configure marked for markdown rendering with syntax highlighting
marked.setOptions({
  highlight: function (code, lang) {
    if (lang && hljs.getLanguage(lang)) {
      return hljs.highlight(code, { language: lang }).value;
    }
    return hljs.highlightAuto(code).value;
  },
  breaks: true,
});

// Use route files
app.use("/auth", authRoutes);
app.use("/quiz", quizRoutes); // Add this line

// Import auth middleware
const { ensureAuth } = require("./middleware/auth");

// Route for homepage
app.get("/", (req, res) => {
  res.render("index");
});

// Get directory structure for sidebar
async function getDirectoryStructure(directoryPath) {
  const basePath = path.join(__dirname, ".."); // Go up one level to reach root project
  const fullPath = path.join(basePath, directoryPath);

  try {
    const items = await fs.readdir(fullPath);
    const structure = [];

    for (const item of items) {
      const itemPath = path.join(fullPath, item);
      const stats = await fs.stat(itemPath);

      // Exclude node_modules, website directories, .git, and GETTING_STARTED.md
      if (
        item !== "node_modules" &&
        item !== "website" &&
        item !== ".git" &&
        item !== "GETTING_STARTED.md" &&
        (directoryPath !== "" || item !== "README.md") && // Only exclude README.md at root level
        item !== ".github"
      ) {
        if (stats.isDirectory()) {
          structure.push({
            name: item,
            path: path.join(directoryPath, item),
            type: "directory",
            children: await getDirectoryStructure(
              path.join(directoryPath, item)
            ),
          });
        } else if (path.extname(item) === ".md") {
          structure.push({
            name: item,
            path: path.join(directoryPath, item),
            type: "file",
          });
        } else if (path.extname(item) === ".dart") {
          // Check if there's a corresponding .txt file with the gist URL
          const txtFilePath = path.join(
            fullPath,
            `${path.parse(item).name}.txt`
          );
          let gistId = null;

          try {
            const txtExists = await fs
              .stat(txtFilePath)
              .then(() => true)
              .catch(() => false);
            if (txtExists) {
              const gistUrl = (await fs.readFile(txtFilePath, "utf8")).trim();
              // Extract gist ID from URL (https://gist.github.com/username/gistId)
              gistId = gistUrl.split("/").pop();
            }
          } catch (error) {
            console.error(`Error reading gist file for ${item}:`, error);
          }

          structure.push({
            name: item,
            path: path.join(directoryPath, item),
            type: "file",
            gistId: gistId,
          });
        }
      }
    }

    // Sort structure with theory content first, then by difficulty levels
    structure.sort((a, b) => {
      // Define content type priorities: theory first, then code examples
      const isTheoryA =
        a.name.toLowerCase().includes("theory") ||
        a.name.toLowerCase().includes("introduction") ||
        a.name.toLowerCase().includes("concept") ||
        a.name.toLowerCase().includes("readme");
      const isTheoryB =
        b.name.toLowerCase().includes("theory") ||
        b.name.toLowerCase().includes("introduction") ||
        b.name.toLowerCase().includes("concept") ||
        b.name.toLowerCase().includes("readme");

      // If one is theory and the other isn't, prioritize theory
      if (isTheoryA && !isTheoryB) return -1;
      if (!isTheoryA && isTheoryB) return 1;

      // Define difficulty order for non-theory content
      const difficultyOrder = { easy: 1, medium: 2, hard: 3 };

      // Check if the items have difficulty levels in their names
      const aLower = a.name.toLowerCase();
      const bLower = b.name.toLowerCase();

      const aDifficulty =
        aLower === "easy" || aLower.includes("_easy")
          ? "easy"
          : aLower === "medium" || aLower.includes("_medium")
          ? "medium"
          : aLower === "hard" || aLower.includes("_hard")
          ? "hard"
          : null;

      const bDifficulty =
        bLower === "easy" || bLower.includes("_easy")
          ? "easy"
          : bLower === "medium" || bLower.includes("_medium")
          ? "medium"
          : bLower === "hard" || bLower.includes("_hard")
          ? "hard"
          : null;

      // If both have difficulty levels, sort by difficulty
      if (aDifficulty && bDifficulty) {
        return difficultyOrder[aDifficulty] - difficultyOrder[bDifficulty];
      }

      // If only one has a difficulty level, prioritize it
      if (aDifficulty) return -1;
      if (bDifficulty) return 1;

      // Default sorting by name for other items
      return a.name.localeCompare(b.name);
    });

    return structure;
  } catch (err) {
    console.error(`Error reading directory ${directoryPath}:`, err);
    return [];
  }
}

// Get file content
async function getFileContent(filePath) {
  const basePath = path.join(__dirname, "..");
  const fullPath = path.join(basePath, filePath);

  try {
    const content = await fs.readFile(fullPath, "utf8");

    // If it's a Dart file, check for a corresponding txt file with Gist URL
    if (path.extname(fullPath) === ".dart") {
      const txtFilePath = fullPath.replace(".dart", ".txt");
      let gistId = null;

      try {
        const txtExists = await fs
          .stat(txtFilePath)
          .then(() => true)
          .catch(() => false);
        if (txtExists) {
          const gistUrl = (await fs.readFile(txtFilePath, "utf8")).trim();
          // Extract gist ID from URL (https://gist.github.com/username/gistId)
          gistId = gistUrl.split("/").pop();
        }
      } catch (error) {
        console.log(`No gist file found for ${filePath}`);
      }

      return {
        content: `<pre><code class="language-dart">${content}</code></pre>`,
        gistId: gistId,
      };
    }

    if (path.extname(fullPath) === ".md") {
      return { content: `<div class="p-4">${marked.parse(content)}</div>` };
    }

    return {
      content: `<pre><code class="p-4">${content}</code></pre>`,
    };
  } catch (err) {
    console.error(`Error reading file ${filePath}:`, err);
    return {
      content:
        '<div class="text-red-500 p-4">Error: Could not load file content</div>',
      gistId: null,
    };
  }
}

// Find previous and next files
async function findPrevAndNext(structure, currentPath) {
  // Flatten the structure to get a list of all files
  function flatten(items) {
    let flat = [];
    for (const item of items) {
      if (item.type === "file") {
        flat.push(item);
      } else if (item.children) {
        flat = flat.concat(flatten(item.children));
      }
    }
    return flat;
  }

  const allFiles = flatten(structure);
  const currentIndex = allFiles.findIndex((file) => file.path === currentPath);

  return {
    prev: currentIndex > 0 ? allFiles[currentIndex - 1] : null,
    next:
      currentIndex < allFiles.length - 1 ? allFiles[currentIndex + 1] : null,
  };
}

// Dashboard route - protected with authentication
app.get("/dashboard", ensureAuth, async (req, res) => {
  const structure = await getDirectoryStructure("");
  const selectedPath = req.query.path || "";
  let content = "";
  let gistId = null;
  let prevNext = { prev: null, next: null };

  if (selectedPath) {
    const fileData = await getFileContent(selectedPath);
    content = fileData.content;
    gistId = fileData.gistId;
    prevNext = await findPrevAndNext(structure, selectedPath);
  } else {
    const fileData = await getFileContent("README.md");
    content = fileData.content;
  }

  res.render("dashboard", {
    structure,
    selectedPath,
    content,
    gistId,
    prevNext,
  });
});

// Full screen content route - protected with authentication
app.get("/fullscreen", ensureAuth, async (req, res) => {
  const filePath = req.query.path || "README.md";
  const fileData = await getFileContent(filePath);
  const content = fileData.content;
  const gistId = fileData.gistId;

  // Get structure and find prev/next navigation
  const structure = await getDirectoryStructure("");
  const prevNext = await findPrevAndNext(structure, filePath);

  // Extract filename for the title
  let title = "DSA with Dart";
  if (filePath) {
    const pathParts = filePath.split("/");
    title = pathParts[pathParts.length - 1];
  }

  res.render("fullscreen", {
    content,
    filePath,
    title,
    gistId,
    prevNext,
  });
});

// API route for dynamically loading file content - protected with authentication
app.get("/api/file-content", ensureAuth, async (req, res) => {
  try {
    const structure = await getDirectoryStructure("");
    const selectedPath = req.query.path || "";
    let content = "";
    let gistId = null;
    let prevNext = { prev: null, next: null };

    if (selectedPath) {
      const fileData = await getFileContent(selectedPath);
      content = fileData.content;
      gistId = fileData.gistId;
      prevNext = await findPrevAndNext(structure, selectedPath);
    } else {
      const fileData = await getFileContent("README.md");
      content = fileData.content;
    }

    res.json({ content, gistId, prevNext });
  } catch (error) {
    console.error("Error serving API content:", error);
    res.status(500).json({ error: "Failed to load content" });
  }
});

// Quiz page route - protected with authentication
app.get("/quiz", ensureAuth, (req, res) => {
  res.render("quiz", {
    title: "DSA Quiz",
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
