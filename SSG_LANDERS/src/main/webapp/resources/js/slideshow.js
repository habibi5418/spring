var slide = document.querySelector("#slideShow");
var slides = document.querySelectorAll("#slides > img");
var prev = document.getElementById("prev");
var next = document.getElementById("next");
var current = -1;
var timeout = 0;

showAutoSlides();
prev.onclick = prevSlide;
next.onclick = nextSlide;

function showAutoSlides() {
  for (let i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  // 모든 이미지 감춤
  }
  current++; // 다음 이미지로 이동
  if(current > slides.length - 1)  // 마지막 이미지라면
    current = 0;   // 첫 번째로 이동
  slides[current].style.display = "block";  // 현재 위치 이미지 표시
  timeout = setTimeout(showAutoSlides, 3000);
}

function showSlides(n) {
  for (let i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slides[n].style.display = "block";
}

function prevSlide() {
  if (current > 0) current -= 1;
  else
    current = slides.length - 1;
  showSlides(current);
}

function nextSlide() {
  if (current < slides.length - 1) current += 1;
  else
    current = 0;
  showSlides(current);  
}

slide.addEventListener("mouseover", () => {
  clearTimeout(timeout);
});

slide.addEventListener("mouseout", () => {
  timeout = setTimeout(showAutoSlides, 3000);
});