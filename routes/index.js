var express = require('express');
var UserModels = require("../models/users.model");
var router = express.Router();

const checkToken = (req, res, next) => {
  console.log("Đang log");
  const header = req.headers["authorization"];

  if (typeof header !== "undefined") {
    const bearer = header.split(" ");
    const token = bearer[1];

    req.token = token;
    next();
  } else {
    //If header is undefined return Forbidden (403)
    res.sendStatus(403);
  }
};

/* POST new admin. */
router.post("/addadmin", checkToken, function(req, res, next) {
  var entity = {
    email: req.body.email,
    password: req.body.password,
    role: 'admin',
    fullname: req.body.fullname,
    avatar: req.body.avatar,
    address: req.body.address,
    major: req.body.major,
    price: req.body.price,
    introduction: req.body.introduction,
  }

  console.log(entity);

  UserModels.single(entity.email).then(row => {
    if (row.length === 0) {
      UserModels.add(entity).then(()=> {
        delete entity['password'];
        res.status(200).json(entity);
      })
    } else {
      res.status(400).json({
        error: "Đăng ký thất bại, tài khoản đã tồn tại",
      })
    }
  })
});

/* GET user profile. */
router.get("/me", checkToken, function(req, res, next) {
  res.json(req.user);
});

module.exports = router;