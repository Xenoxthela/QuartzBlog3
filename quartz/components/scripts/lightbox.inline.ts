
// Lightbox-Element erstellen und verstecken
const lightbox = document.createElement('div');
lightbox.id = 'lightbox';
lightbox.style.display = 'none';
lightbox.style.position = 'fixed';
lightbox.style.top = '0';
lightbox.style.left = '0';
lightbox.style.width = '100%';
lightbox.style.height = '100%';
lightbox.style.backgroundColor = 'rgba(0, 0, 0, 0.8)';
lightbox.style.zIndex = '1000';
lightbox.style.justifyContent = 'center';
lightbox.style.alignItems = 'center';
document.body.appendChild(lightbox);

// Lightbox anzeigen, wenn auf ein Bild geklickt wird
document.querySelectorAll('img').forEach(image => {
  image.addEventListener('click', () => {
    lightbox.style.display = 'flex';
    const img = document.createElement('img');
    img.src = image.src;
    img.style.maxWidth = '80%';
    img.style.maxHeight = '80%';
    // Entfernen Sie zuerst das aktuelle Bild, falls vorhanden
    while (lightbox.firstChild) {
      lightbox.firstChild.remove();
    }
    lightbox.appendChild(img);
  });
});

// Lightbox ausblenden, wenn darauf geklickt wird
lightbox.addEventListener('click', () => {
  lightbox.style.display = 'none';
});
