import React from 'react';

class App extends React.Component {
  constructor() {
    super();
    this.state = {
      tasks: [],
      isLoading: true
    };
  }

  componentDidMount() {
    console.log("component did mount");
    const request = new Request('/api/tasks', {
      method: 'GET',
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    });
    fetch(request).then((response) => {
      return response.json();
    }).then((json) => {
      console.log("set state");
      this.setState({
        tasks: json.tasks,
        isLoading: false
      });
    })
  }

  componentWillUnmount(){
    console.log("component will unmount");
  }

  render() {
    if (this.state.isLoading) {
      return <p>loading . . . </p>;
    }

    return (
      <div>
        <ul>
          {
            this.state.tasks.map((task) => (
              <li>
                task
              </li>
            ))
          }
        </ul>
      </div>
    )
  }
}

export default App;
