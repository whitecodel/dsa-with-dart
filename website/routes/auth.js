const express = require("express");
const passport = require("passport");
const router = express.Router();

// @route   GET /auth/github
// @desc    Authenticate with GitHub
router.get(
  "/github",
  passport.authenticate("github", { scope: ["user:email"] })
);

// @route   GET /auth/github/callback
// @desc    GitHub callback
router.get(
  "/github/callback",
  passport.authenticate("github", { failureRedirect: "/" }),
  (req, res) => {
    // Successful authentication, redirect to dashboard
    res.redirect("/dashboard");
  }
);

// @route   GET /auth/logout
// @desc    Logout user
router.get("/logout", (req, res) => {
  req.logout((err) => {
    if (err) {
      console.error("Error during logout:", err);
      return res.redirect("/dashboard");
    }
    res.redirect("/");
  });
});

module.exports = router;
