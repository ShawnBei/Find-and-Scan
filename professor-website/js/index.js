
var database = firebase.database();


function logIn() {

	var userEmail = document.getElementById("email_field").value;
	var userPass= document.getElementById("password_field").value;


	firebase.auth().signInWithEmailAndPassword(userEmail, userPass).catch(function(error) {

	  var errorCode = error.code;
	  var errorMessage = error.message;
	  
	  alert("Error: " + errorMessage);
	});

	var user = firebase.auth().currentUser;

	if (user) {
	  // User is signed in.

	  var userId = firebase.auth().currentUser.uid;

	  var position;

		firebase.database().ref('/users/' + userId + '/Position').once('value').then(function(snapshot) {

  			position = snapshot.val();

  			if(position == "Professor") {
				window.location.replace("http://www.ningbei001.com/login.html");
			}
			else{
				alert("Sorry, this is only for Professor use!");
			}
		});
	}  
}




function logOut(){

	firebase.auth().signOut().then(function() {
	  // Sign-out successful.

	  window.location.replace("http://www.ningbei001.com");

	}).catch(function(error) {
	  // An error happened.

	  alert("Error");

	});

}


var flag = true;

// For todays date;
//Date.prototype.today = function () { 
 //   return this.getFullYear() + "-" + (((this.getMonth()+1) < 10)?"0":"") + (this.getMonth()+1) + "-" + ((this.getDate() < 10)?"0":"") + this.getDate();
//}

// For the time now
//Date.prototype.timeNow = function () {
//     return ((this.getHours() < 10)?"0":"") + this.getHours() +":"+ ((this.getMinutes() < 10)?"0":"") + this.getMinutes() +":"+ ((this.getSeconds() < 10)?"0":"") + this.getSeconds();
//}



function getCode() {

	makeCode();

	if(flag){
		document.getElementById("first_div").style.display = "none";
		document.getElementById("qrcode").style.display = "block";
	}
}


function makeCode () {		
	var elText = document.getElementById("course_field");
				
	if (!elText.value) {
		alert("Please input a course!");
		flag = false;
		elText.focus();
		return;
	}
	else{
		flag = true;
	}

	setInterval(function(){

		//var currentTime = newDate.today() + " " + newDate.timeNow();

		qrcode.makeCode(Date.now() + " "+ elText.value);

	}, 1000);
}



