import React from 'react';
import Header from './header';
import TaskForm from './task-form';
import TaskTable from './task-table';

class App extends React.Component {
  constructor(props) {
    super(props);

    // タスク一覧を格納する配列を state として初期化
    this.state = {
      tasks: [],
    }

    // タスクを取得するメソッドを this に bind
    this.getTasks = this.getTasks.bind(this);
  }

  componentDidMount() {
    // コンポーネントマウント時にタスク一覧を取得する
    this.getTasks()
  }

  getTasks() {
    // Rails 側の /api/v1/tasks に GET リクエストを送ってタスク一覧を取得
    let request = new Request('/api/v1/tasks', {
      method: 'GET',
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    });

    fetch(request).then(function (response) {
      return response.json();
    }).then(function (tasks) {
      // 取得が完了したら state にセットする
      this.setState({
        tasks: tasks
      });
    }.bind(this)).catch(function (error) {
      console.error(error);
    });
  }

  render() {
    const { tasks } = this.state;

    return (
      <div>
        <Header title='Rails 5.1 + webpacker + React + Reactstrap Example' />
        <div>
          {/*
            * TaskForm コンポーネント起因でタスクを作成した際に
            * タスク一覧を再取得するために
            * getTasks メソッドを props として渡す
            */}
          <TaskForm getTasks={this.getTasks} />
          {/*
            * TaskRow (TaskTable の中) コンポーネント起因でタスクを削除した際に
            * タスク一覧を再取得するために
            * getTasks メソッドを props として渡す
            * tasks はタスク一覧
            */}
          <TaskTable tasks={tasks} getTasks={this.getTasks} />
        </div>
      </div>
    )
  }
}

export default App;
