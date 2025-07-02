module.exports = {
  // Check if user is authenticated
  ensureAuth: function (req, res, next) {
    if (!req.isAuthenticated()) {
      return next();
    } else {
      res.redirect("/");
    }
  },

  // Check if user is not authenticated (for routes that should be accessed only when logged out)
  ensureGuest: function (req, res, next) {
    if (!req.isAuthenticated()) {
      res.redirect("/dashboard");
    } else {
      return next();
    }
  },
};
