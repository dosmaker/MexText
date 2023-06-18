function scrollToElement() {
    const element = document.getElementById("feature");
    const targetOffset = element.offsetTop - 100;
    const duration = 1000;
    const startingYOffset = window.pageYOffset;
    let start;
    
    function scrollStep(timestamp) {
      if (!start) start = timestamp;
      const elapsed = timestamp - start;
      const progress = Math.min(elapsed / duration, 1);
      const y = startingYOffset + ((targetOffset - startingYOffset) * progress);
      window.scrollTo(0, y);
      if (elapsed < duration) {
        window.requestAnimationFrame(scrollStep);
      }
    }
    
    window.requestAnimationFrame(scrollStep);
}

function feature(){
    const urlParams = new URLSearchParams(window.location.search);
    const id = urlParams.get('id');
    if(id == "feature"){ scrollToElement(); }
}