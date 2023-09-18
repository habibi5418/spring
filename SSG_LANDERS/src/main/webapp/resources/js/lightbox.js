var pics = document.getElementsByClassName("pic");
var lightbox = document.getElementById("lightbox");  
var lightboxImage = document.getElementById("lightboxImage");  

for (i=0; i<pics.length; i++) {
	pics[i].addEventListener("click", showLightbox);
}

function showLightbox() {
	var bigLocation = this.getAttribute("data-src"); 
	lightboxImage.setAttribute("src", bigLocation); 
	lightbox.style.display = "block"; 
	if (lightboxImage.width < lightboxImage.height) {
		lightboxImage.style.height = 100 + "%";
	} else {
		lightboxImage.style.height = 75 + "%";
	}
}
  
lightbox.onclick = function() {  //click 이벤트가 발생했을 때 실행할 함수 선언
	lightbox.style.display = "none";  // lightbox 요소를 화면에서 감춤
}