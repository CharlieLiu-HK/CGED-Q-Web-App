const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    const square = entry.target.querySelector('.card');
    if (entry.isIntersecting) {
      square.classList.add('card-transition');
	  return;
    }
    square.classList.remove('card-transition');
  });
});


window.addEventListener('scroll', () => {
   elementsList = document.querySelectorAll(".col");
   [...elementsList].forEach((element) => {observer.observe(element)});
});