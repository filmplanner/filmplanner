import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'mobx-react'

import MovieSelectorApp from 'components/MovieSelectorApp'
import MovieSelectorStore from 'stores/MovieSelectorStore'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('movie-selector-app')

  const app = (
    <Provider MovieSelectorStore={MovieSelectorStore}>
      <MovieSelectorApp/>
    </Provider>
  )

  ReactDOM.render(app, node)
})