(function(){
	console.log(SLIDES_DATA)
	var aSlides = document.querySelector('div.slides');
	var i,
		aTabOfSlides = SLIDES_DATA.slides,
		aLength = aTabOfSlides.length,
		path = "/src/slides/",
		aSection;
	for(i = 0 ; i < aLength; i++){
		aSection = document.createElement("SECTION");
		aSection.setAttribute("data-markdown", path+aTabOfSlides[i]);
		aSection.setAttribute("data-separator", "^<nsh>");
		aSection.setAttribute("data-separator-vertical", "^<nsv>");
		aSection.setAttribute("data-separator-notes", "^Note:");
		aSection.setAttribute("data-charset", "utf-8");
		aSlides.appendChild(aSection);
	}
})()