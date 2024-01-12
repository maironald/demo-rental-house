document.addEventListener('turbolinks:load', function(){
  var navLinks = document.querySelectorAll(".nav-side-menu li a")
  console.log(navLinks);
  navLinks.forEach((link)=>{
      link.addEventListener('click', function(event){
          event.preventDefault();
          navLinks.forEach(function (navLink){
              navLink.classList.remove('active');
          })
          location.href = link.getAttribute('href');
          link.classList.add('active');
      })
  })

})

let check = true;

document.addEventListener('DOMContentLoaded', function(event){
  var buttonClose = document.querySelector(".left-toggle a");
  event.preventDefault();
  buttonClose.addEventListener('click',function(event){
      console.log(check);
      event.preventDefault();
      var windowWidth = window.innerWidth;
      if(windowWidth > 991){
          if (!check){
              document.querySelector("body").classList.remove('nav-sm');
              document.getElementById("right-container").style.marginLeft = "230px";
              check = true;
              document.getElementById("site-title").innerText = "QUẢN LÝ NHÀ TRỌ"
          }else{
              document.getElementById("left-div").style.display = "block";
              document.getElementById("right-container").style.marginLeft = "80px"
              document.querySelector("body").classList.add('nav-sm');
              document.getElementById("site-title").innerText = "QLNT"
              check = false;
          }
      } else {
          if(!check){
              document.getElementById("left-div").style.display = "none";
              document.getElementById("right-container").style.marginLeft = "0";
              check = true;
          } else{
              document.getElementById("left-div").style.display = "block";
              document.getElementById("right-container").style.marginLeft = "80px"
              document.querySelector("body").classList.add('nav-sm');
              document.getElementById("site-title").innerText = "QLNT"
              check = false;
          }

      }
  })
  window.addEventListener('resize', function () {

      if (window.innerWidth > 991) {
          this.document.getElementById("right-container").style.marginLeft = "230px";
          document.getElementById("left-div").style.display = "block";
          document.querySelector("body").classList.remove('nav-sm');
          document.getElementById("site-title").innerText = "QUẢN LÝ NHÀ TRỌ"
          check = true;
      } else {
          this.document.getElementById("right-container").style.marginLeft = "0";
          this.document.getElementById("left-div").style.display = "none";
          check = true;
      }

  });
})
