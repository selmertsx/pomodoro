import React from 'react'
import ReactDOM from 'react-dom'
import App from '../components/app'
import "babel-polyfill"

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.getElementById('example-app')
  )
})
