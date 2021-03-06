var express = require("express");
var UserModels = require("../models/users.model");
var SkillsModels = require("../models/skills.model");
var ContractsModels = require("../models/contracts.model");
var ComplainModels = require("../models/complain.model");
var router = express.Router();
var appa = require("../firebaseCfg");

const checkToken = (req, res, next) => {
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

router.get("/users", function(req, res, next) {
  UserModels.all().then(rows => {
    console.log(rows);
    res.status(200).json(rows);
  });
});

router.get("/skills", function(req, res, next) {
  SkillsModels.all().then(rows => {
    res.status(200).json(rows);
  });
});

router.get("/contracts", function(req, res, next) {
  ContractsModels.detail().then(rows => {
    res.status(200).json(rows);
  });
});

router.post("/skill", function(req, res, next) {
  var entity = {
    skill: req.body.newSkill,
    state: 1
  };

  SkillsModels.single(req.body.newSkill).then(rows => {
    if (rows.length === 0) {
      SkillsModels.add(entity)
        .then(id => {
          entity["id"] = id;
          res.status(200).json({ skill: entity });
        })
        .catch(error => {
          console.log(error);
          res.status(400).json({ error: "Thêm kỹ năng thất bại" });
        });
    } else {
      res.status(400).json({ error: "Kỹ năng đã tồn tại" });
    }
  });
});

router.post("/deleteskill", function(req, res, next) {
  var entity = req.body;

  SkillsModels.update(entity)
    .then(row => {
      res.status(200).json({ error: "Thành công", skill: row });
    })
    .catch(() => {
      res.status(400).json({ error: "Thất bại" });
    });
});

router.post("/updateskill", function(req, res, next) {
  var entity = req.body;
  SkillsModels.update(entity)
    .then(row => {
      res.status(200).json({ error: "Thành công", skill: row });
    })
    .catch(() => {
      res.status(400).json({ error: "Thất bại" });
    });
});

router.post("/updateuser", function(req, res, next) {
  var entity = req.body.user;
  console.log(entity);
  UserModels.update(entity)
    .then(user => {
      console.log(user);
      res.status(200).json({ error: "Thành công", user });
    })
    .catch(() => {
      res.status(400).json({ error: "Thất bại" });
    });
});

router.post("/complain", function(req, res, next) {
  var entity = req.body.complain;
  var { isSuccess } = entity;
  delete entity["isSuccess"];
  ComplainModels.updateByContractId(entity)
    .then(user => {
      console.log(entity);
      let newEntity = {};
      if (isSuccess) {
        newEntity = {
          id: entity.id,
          state: 2
        };
      } else {
        newEntity = {
          id: entity.id,
          state: 2
        };
      }
            ContractsModels.update(newEntity)
        .then(rows => {
          res.status(200).json({ error: "Thành công", rows });
        })
        .catch(() => {
          res.status(400).json({ error: "Thất bại" });
        });
    })
    .catch(() => {
      res.status(400).json({ error: "Thất bại" });
    });
});

/* POST new admin. */
router.post("/createadmin", checkToken, function(req, res, next) {
  var entity = req.body.user;
  entity.role = "admin";

  UserModels.single(entity.email).then(row => {
    if (row.length === 0) {
      UserModels.add(entity).then(() => {
        delete entity["password"];
        res.status(200).json(entity);
      });
    } else {
      res.status(400).json({
        error: "Đăng ký thất bại, tài khoản đã tồn tại"
      });
    }
  });
});

/* GET user profile. */
router.get("/me", checkToken, function(req, res, next) {
  res.json(req.user);
});

router.post("/chartdata", function(req, res, next) {
  const { type } = req.body;
  console.log(type);
  ContractsModels.detailByType(type)
    .then(rows => {
      if (type === "date" || type === "week")
        for (let i = 0; i < rows.length; i++) {
          rows[i].date = (rows[i].date + "").substring(0, 10);
        }
      res.status(200).json({ chartData: rows });
    })
    .catch(err => {
      res.status(400).json({ err });
    });
});

router.post("/salesbyteacher", function(req, res, next) {
  const { type } = req.body;
  ContractsModels.salesByTeacher(type)
    .then(rows => {
      res.status(200).json({ salesByTeacher: rows });
    })
    .catch(err => {
      res.status(400).json({ err });
    });
});

router.post("/salesbyskill", function(req, res, next) {
  const { type } = req.body;
  ContractsModels.salesBySkill(type)
    .then(rows => {
      res.status(200).json({ salesBySkill: rows });
    })
    .catch(err => {
      res.status(400).json({ err });
    });
});

router.get("/summaryreport", function(req, res, next) {
  ContractsModels.totalSales()
    .then(sales => {
      const response = {
        sales: sales[0].sales
      };
      UserModels.totalUsers()
        .then(users => {
          response.users = users[0].users;
          ContractsModels.totalContracts()
            .then(contracts => {
              response.contracts = contracts[0].contracts;
              SkillsModels.totalSkills()
                .then(skills => {
                  response.skills = skills[0].skills;
                  res.status(200).json(response);
                })
                .catch(err => {
                  res.status(400).json(err);
                });
            })
            .catch(err => {
              res.status(400).json(err);
            });
        })
        .catch(err => {
          res.status(400).json(err);
        });
    })
    .catch(err => {
      res.status(400).json(err);
    });
});

router.post("/updateprofile", function(req, res, next) {
  const entity = req.body;
  console.log(entity);
  UserModels.update(entity).then(idChange => {
    UserModels.singleById(idChange).then(rows => {
      res.status(200).json({ user: rows[0] });
    });
  });
});

router.get("/chatcontent/:email1/:email2", function(req, res, next) {
  const { email1, email2 } = req.params;
  const database = appa.database().ref();
  database.on("value", snap => {
    snap.forEach(childNode => {
      if (
        (childNode.val().metadata &&
          childNode.val().metadata.u1 === email1 &&
          childNode.val().metadata.u2 === email2) ||
        (childNode.val().metadata &&
          childNode.val().metadata.u2 === email1 &&
          childNode.val().metadata.u1 === email2)
      ) {
        // console.log(childNode)
        res.status(200).json({ messages: childNode });
      }
    });
  });
});

router.post("/contractdetail", function(req, res, next) {
  const { id } = req.body;
  ContractsModels.detailById(id)
    .then(information => {
      ComplainModels.allByContractId(id)
        .then(complains => {
          res.status(200).json({ information: information[0], complains });
        })
        .catch(err => {
          res.status(400).json(err);
        });
    })
    .catch(err => {
      res.status(400).json(err);
    });
});

module.exports = router;
