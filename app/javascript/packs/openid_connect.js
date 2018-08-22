// First, parse the query string
let params = {}
const postBody = location.hash.substring(1);
const regex = /([^&=]+)=([^&]*)/g;
let m;
while (m = regex.exec(postBody)) {
  params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
}

var req = new XMLHttpRequest();
req.open('POST', '//' + window.location.host + '/authorization', true);
req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
var token = document.querySelector("meta[name='csrf-token']").attributes['content'].value;
req.setRequestHeader('X-CSRF-Token', token);

req.onreadystatechange = function (e) {
  if (req.readyState == 4) {
    if (req.status == 200) {
      const res =JSON.parse(req.response);
      // 本来ならばSPAでゴリゴリやりたいが、僕の実装能力が足りないので、一旦Railsレイヤーに処理を戻す
      const url = '//' + window.location.host + '/authorization/after_login?name=' + res["name"] + '&preferred_username=' + res["preferred_username"];
      window.location.href = url;
    }
    else if (req.status == 400) {
      alert('There was an error processing the token')
    } else {
      alert('Something other than 200 was returned')
    }
  }
};
req.send(postBody);
