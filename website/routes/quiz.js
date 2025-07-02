const express = require("express");
const router = express.Router();
const { ensureAuth } = require("../middleware/auth");
const fs = require("fs");
const path = require("path");

const quizBasePath = path.join(__dirname, "../../Quiz");

router.get("/", ensureAuth, (req, res) => {
  const quizType = req.query.type;

  if (!quizType) {
    return res.render("quiz");
  } else {
    const directoryPath = path.join(quizBasePath, quizType);

    const questions = [];

    fs.readdir(directoryPath, (err, files) => {
      if (err) {
        console.error("Could not list the directory.", err);
        return res.status(500).send("Error reading quiz files.");
      }

      files.forEach((file) => {
        if (path.extname(file) === ".json") {
          const filePath = path.join(directoryPath, file);
          const questionData = JSON.parse(fs.readFileSync(filePath, "utf8"));
          questions.push(questionData);
        }
      });

      console.log(questions);

      res.render("quiz", { questions, quizType });
    });
  }
});

module.exports = router;
