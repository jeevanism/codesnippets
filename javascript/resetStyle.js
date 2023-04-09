/**
 * a JavasScript snippet to remove all style in a web page
 */


// Get all the stylesheets on the page
const stylesheets = Array.from(document.getElementsByTagName('link'));

// Remove each stylesheet from the document
stylesheets.forEach(stylesheet => {
    stylesheet.parentNode.removeChild(stylesheet);
});

// Remove all inline styles from elements on the page
Array.from(document.getElementsByTagName('*')).forEach(element => {
    element.removeAttribute('style');
});

// Optional: Reload the page to reset all styles to the default
location.reload();
