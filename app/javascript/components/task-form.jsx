import React from 'react';

class TaskForm extends React.Component {
  constructor(props) {
    super(props)

    // 入力フォーム(input) 用の state をセットしておく
    this.state = {
      title: '',
      description: ''
    }

    //　タスクを作成するメソッドを this に bind する
    this.createTask = this.createTask.bind(this);
  }

  createTask(event) {
    // Rails 側の /api/v1/tasks を POST メソッドで叩き、タスクを作成する
    let request = new Request('/api/v1/tasks', {
      method: 'POST',
      headers: new Headers({
        'Content-Type': 'application/json'
      }),
      body: JSON.stringify({
        title: this.state.title,
        description: this.state.description
      })
    });

    fetch(request).then(function (response) {
      return response.json();
    }).then((task) => {
      // タスク作成が成功したら、タスク一覧を再取得する
      this.props.getTasks();
    }).catch(function (error) {
      console.error(error);
    }).finally(() => {
      this.setState({
        title: '',
        description: ''
      })
    });

    // preventDefault でブラウザ起因の onSubmit イベントを打ち消す
    // この記述が無いとページが遷移してしまう
    event.preventDefault();
  }

  render() {
    let { title, description } = this.state;

    return (
      <form onSubmit={this.createTask}>
        <label>Title</label>
        <input
          type="text" value={title}
          placeholder="Title"
          onChange={(e) => {
            this.setState({
              title: e.target.value
            })
          }}
        />
        <label className="mr-sm-2">Description</label>
        <input
          type="text" value={description}
          placeholder="Description"
          onChange={(e) => {
            this.setState({
              description: e.target.value
            })
          }}
        />
        <input type="submit" value="Create Task" />
      </form>
    )
  }
}

export default TaskForm;
