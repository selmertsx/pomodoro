import React from 'react';

class App extends React.Component {
  constructor() {
    super();
    this.state = {
      tasks: []
    };
  }

  componentDidMount() {
    const request = new Request('/api/tasks', {
      method: 'GET',
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    });

    fetch(request).then((response) => {
      return response.json();
    }).then((tasks) => {
      this.setState({tasks});
    })
  }

  render() {
    const { tasks } = this.state;
    return (
      <div>
        <ul>
          {
            tasks.map((task) => {
              return (
                <li> {task.name} </li>
              );
            })
          }
        </ul>
      </div>
    )
  }
}

export default App;
