const express = require('express');
const app = express();
const mysql = require('mysql');
const session = require('express-session');
const flash = require('connect-flash');
app.use(session({secret:'thisissecret'}));
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const path = require('path');


const db=mysql.createConnection({
  host:'localhost',
  user:'root',
  password:'',
  database:'school'
})


db.connect((err)=>{
  if(err){
    console.log(err);
  }else{
    console.log("Connected");
  }
})




app.set('view engine', 'ejs');
app.set('views','views');
app.use(express.urlencoded({extended:true}));
app.use(express.static(path.join(__dirname,'public')));
app.set('views',path.join(__dirname,'views'));
app.use(flash());






//Home page
app.get('/',(req,res)=>{
  res.render('home')
})


// end of Home page

// REgister Form
app.get('/register',(req,res)=>{
  res.render('register');
})

//Register post

app.post('/register',async(req,res)=>{
  const {firstName,lastName,email,password,passwordConf,roll}=req.body;
  db.query('SELECT email FROM student WHERE email=?',[email],async(err,result)=>{
    if(err){
      console.log("error in email cheking");
      console.log(err);
    }
    if(result.length>0){
      console.log("email is Not available");
       res.render('register');
    }else if(password !== passwordConf) {
      console.log("incorrect password");
       res.render('register');
    }else{
      if(roll=="student"){
        const hash=await bcrypt.hash(password,8);
        db.query('INSERT INTO student SET ?',{firstName:firstName,lastName:lastName,email:email,password:hash,roll:roll},(err,result)=>{
          if(err){
            console.log(err);
          }else{
            res.redirect('register');
          }
        })
      }else{
        const hash =await bcrypt.hash(password,8);
        db.query('INSERT INTO teatcher SET ?',{firstName:firstName,lastName:lastName ,email:email,password:hash,roll:roll},(err,result)=>{
          if(err){
            console.log(err);
          }else{
          //  req.session.userId=id;
            res.redirect('register');
          }
        })

      }

    }
  })

})

//Login Form
app.get('/login',(req,res)=>{
  res.render('login',{messages:req.flash('wrongpassword')});
})

//login Post
app.post('/login',(req,res)=>{
  const {email,password}=req.body;
  db.query('SELECT * FROM student WHERE email =?',[email],async(err,result)=>{
    console.log("the result is " + result);
    if (result==""){
      console.log("you r not student");
      db.query('SELECT * FROM teatcher WHERE email =?',[email],async(err,result)=>{
        if(!(await bcrypt.compare(password,result[0].password))){
          req.flash('wrongpassword','Email or password is incorrect')
          console.log("wrong password teatcher");
        //  res.send('try again teacher');
        res.redirect('login');
        }else{
          const id=result[0].id;
              const nameOfUser=result[0].firstName;
              req.session.userId=id;
              req.session.name=nameOfUser;
              const password=result[0].password;
              console.log("your Id is : " + id + " your password is : " + password);
              res.redirect('teacher');
        }
      })





    }else{
      if(!(await bcrypt.compare(password,result[0].password))){
        req.flash('wrongpassword','Email or password is incorrect')
        console.log("wrong password teatcher");
      //  res.send('try again teacher');
      res.redirect('login');
    }else{
      const id=result[0].id;
          const nameOfUser=result[0].firstName;
          req.session.userId=id;
          req.session.name=nameOfUser;
          const password=result[0].password;
          console.log("your Id is : " + id + " your password is : " + password);
          res.redirect('dashbord');
    }


    }
  });

});





//Log out from dashbord
app.post('/logout',(req,res)=>{
  req.session.userId=null;
  res.redirect('login');
})


//dashbord
app.get('/dashbord',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found ');
  }else{
    const userName =req.session.name;
      res.render('dashbord',{username:userName});
 }
})

//teacher dashbord
app.get('/teacher',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found');
  }else{
    const userName=req.session.name;
    res.render('teacher',{username:userName});
  }
})





// subjects page
app.get('/subjects',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found ');
  }else{
    db.query('SELECT * FROM subject',async(err,result)=>{
      var sub_id=[];
      var sub_name=[];
      var sub_time=[];
      var sub_room=[];
      var sub_teacher_id=[];
      for(var i=0;i<result.length;i++){
        sub_id.push(result[i].id);
        sub_name.push(result[i].name);
        sub_time.push(result[i].time);
        sub_room.push(result[i].room);
        sub_teacher_id.push(result[i].t_id);
      }
    //  console.log(" id is "+ sub_id + " name is " + sub_name + " teacher " + sub_teacher_id);
      res.render('subjects',{ids:sub_id, names:sub_name , times :sub_time,rooms:sub_room, teachers:sub_teacher_id,sub_msg:req.flash('subject'),suc_msg:req.flash('success')});

    })

  //  res.render('subjects');
  }
})

//adding subjects to the education
app.post('/education',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found');
  }else{
    var user_id=req.session.userId;
    var sub_id=req.body.hidden_id;
    //cheking if student allready registerd for the subject
    db.query('SELECT s_id , sub_id FROM education WHERE s_id =? AND sub_id=? ',[user_id,sub_id],async(err,result)=>{
      console.log("result is " + result);
      if(err){
        console.log(err);
      }
      if(result.length>0){
        req.flash('subject','you have already registerd for this subject');
        console.log("you cant register");
        res.redirect('subjects');
      }else{
        db.query('INSERT INTO education SET ?',{s_id:user_id,sub_id:sub_id},(err,result)=>{
          if(err){
            console.log(err);
          }else{
            req.flash('success','you have successfuly registerd')
            console.log("you have registerd");
            res.redirect('subjects');
          }
        })
      }
    })
//
  }
})

//Exam page
app.get('/exams',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found ');
  }else{
    db.query('SELECT * FROM exam',async(err,result)=>{
      var exam_id=[];
      var exam_name=[];
      var exam_date=[];
      var exam_subject_id=[];
      var exam_teacher_id=[];
      for(var i=0;i<result.length;i++){
        exam_id.push(result[i].id);
        exam_name.push(result[i].name);
        exam_date.push(result[i].date);
        exam_subject_id.push(result[i].sub_id);
        exam_teacher_id.push(result[i].t_id);
      }

      // var teacher_names=[];
      // for(var j=0;j<exam_teacher_id.length;j++){
      //   db.query('SELECT firstName FROM teatcher WHERE id = ?',[exam_teacher_id[j]],async(err,newResult)=>{
      //     console.log(newResult);
      //     teacher_names[j]=newResult;
      //
      //   })
      //   console.log("this is new " + teacher_names[j]);
      //
      // }


    //  console.log(" id is "+ sub_id + " name is " + sub_name + " teacher " + sub_teacher_id);
      res.render('exams',{ids:exam_id, names:exam_name , dates :exam_date,subjectsId:exam_subject_id, teachers:exam_teacher_id,exam_wrong:req.flash('exam_wrong'),exam_suc:req.flash('exam_suc')});

    })

  //  res.render('subjects');
  }
})



// Register the exams
app.post('/examRegister',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found');
  }else{
    var user_id=req.session.userId;
    var exam_id=req.body.hidden_id;
    db.query('SELECT s_id , exam_id FROM examRegister WHERE s_id =? AND exam_id=? ',[user_id,exam_id],async(err,result)=>{
      console.log("result is " + result);
      if(err){
        console.log(err);
      }
      if(result.length>0){
        req.flash('exam_wrong','you have already registerd for this exam');
        console.log("you cant register");
        res.redirect('exams');
      }else{
        db.query('INSERT INTO examRegister SET ?',{s_id:user_id,exam_id:exam_id},(err,result)=>{
          if(err){
            console.log(err);
          }else{
            req.flash('exam_suc','you have successfuly registerd');
            console.log("you have registerd");
            res.redirect('exams');
          }
        })
      }
    })
//
  }

})


//Students number page While being a Teacher
app.get('/students',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found');
  }else{
    var teacher_id=req.session.userId;
  //  console.log(teacher_id);
    db.query('SELECT id FROM subject WHERE t_id= ?',[teacher_id],async(err,result)=>{
      if (err){
        console.log(err);
      }else{

        var sub=result[0].id;
      //  console.log(sub);
        db.query('SELECT * FROM student JOIN education on student.id=education.s_id WHERE education.sub_id=? ',[sub],(err,nresult)=>{
        //  console.log(nresult.firstName);
          var studentNames=[];
          var studentLastName=[];
          var studentEmail=[];
          var studentId=[];
          for(var i=0;i<nresult.length;i++){
            studentNames.push(nresult[i].firstName);
            studentLastName.push(nresult[i].lastName);
            studentEmail.push(nresult[i].email);
            studentId.push(nresult[i].s_id);
          }
        //  console.log(studentNames);
          res.render('students',{students:studentNames,lasts:studentLastName,emails:studentEmail,ids:studentId});
        })

        //res.render('students');
      }


    })
  //res.render('students');
  }
})


//Grades Page as a teacher
app.get('/grades',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found');
  }else{
    var teacher_id=req.session.userId;
    db.query('SELECT * FROM subject WHERE t_id= ?',[teacher_id],async(err,result)=>{
      if (err){
        console.log(err);
      }else{
        var subName=[];
        var sub=result[0].id;
      //  console.log("sub id is " + sub);
         subName=result[0].name;
        // console.log(subName);
        db.query('SELECT * FROM student JOIN examRegister on student.id=examRegister.s_id WHERE examRegister.exam_id=? ',[sub],(err,nresult)=>{
          var studentNames=[];
          var studentLastName=[];
          var studentEmail=[];
          var studentId=[];

          for(var i=0;i<nresult.length;i++){
        //    console.log(nresult);
            studentNames.push(nresult[i].firstName);
            studentLastName.push(nresult[i].lastName);
            studentEmail.push(nresult[i].email);
            studentId.push(nresult[i].s_id);
          //  console.log(studentId);
          }

          res.render('grades',{students:studentNames,lasts:studentLastName,subjectNames:subName,ids:studentId,teacherIds:teacher_id,subjectIds:sub,grade_wrong:req.flash('grade_wrong'),grade_suc:req.flash('grade_suc')});
        })

      }


    })
  }
})



//adding grade to data base
app.post('/grade',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found');
  }else{
    var teacher_id=req.session.userId;
    var sub_id=req.body.hidden_subject_id;
    var student_id=req.body.hidden_student_id;
    var student_grade=req.body.grade_num;
    //console.log("sub id is "+ sub_id);
  //  console.log("student id is" + student_id);

    db.query('SELECT result_grade FROM grade WHERE s_id =? AND sub_id=? ',[student_id,sub_id],async(err,result)=>{
  //    console.log("result is " + result);
      if(err){
        console.log(err);
      }
      if(result.length>0){
        req.flash('grade_wrong','there is already a grade for this student');
        console.log("there is already a grade for this student");
        res.redirect('grades');

      }else{
        db.query('INSERT INTO grade SET ?',{s_id:student_id,sub_id:sub_id,t_id:teacher_id,result_grade:student_grade},(err,result)=>{
          if(err){
            console.log(err);
          }else{
            req.flash('grade_suc','you have added a grade');
            console.log("you have added a grade ");
            res.redirect('grades');
          }
        })
      }
    })
  //
  }
})


//Students grade as student
app.get('/studentgrade',(req,res)=>{
  if(!(req.session.userId)){
    res.send('no id found ');
  }else{
    var student=req.session.userId;
  //  console.log(student);
    db.query('SELECT * FROM subject JOIN grade on grade.sub_id=subject.id JOIN teatcher ON teatcher.id=grade.t_id WHERE grade.s_id= ?',[student],async(err,result)=>{
      var sub_id=[];
      var sub_name=[];
      var grade=[];
      var grade_teacher_name=[];
      var grade_teacher_lastname=[];
      for(var i=0;i<result.length;i++){
        sub_id.push(result[i].sub_id);
        sub_name.push(result[i].name);
        //sub_time.push(result[i].time);
        //sub_room.push(result[i].room);
        grade_teacher_name.push(result[i].firstName);
        grade_teacher_lastname.push(result[i].lastName);
        grade.push(result[i].result_grade);
      }
    //  console.log(" id is "+ sub_id + " name is " + sub_name + " teacher " + sub_teacher_id);
      res.render('studentgrade',{ids:student, sub_ids:sub_id ,sub_names:sub_name, grades :grade, teachers:grade_teacher_name,teacher_lasts:grade_teacher_lastname});

    })
  }
})



app.listen(5000,()=>{
  console.log("Listening to Port 5000");
})
