# 心得笔记

# 示例杂记

### `Fetch` - 比 XMLHttpRequest 更灵活的API

*[src](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API)*

`more:` https://fetch.spec.whatwg.org/#dom-body-text

```
var myArticle = document.querySelector('article');
var myLinks = document.querySelectorAll('ul a');

for(i = 0; i <= myLinks.length-1; i++) {
  myLinks[i].onclick = function(e) {
    e.preventDefault();
    var linkData = e.target.getAttribute('data-page');
    getData(linkData);
  }
};
    
function getData(pageId) {
  console.log(pageId);
  var myRequest = new Request(pageId + '.txt');
  fetch(myRequest).then(function(response) {
    return response.text().then(function(text) {
      myArticle.innerHTML = text;
    });
  });
}

```
 //-//

```
var url = 'https://example.com/profile';
var data = {username: 'example'};

fetch(url, {
  method: 'POST', // or 'PUT'
  body: JSON.stringify(data), // data can be `string` or {object}!
  headers: new Headers({
    'Content-Type': 'application/json'
  })
}).then(res => res.json())
.catch(error => console.error('Error:', error))
.then(response => console.log('Success:', response));

```