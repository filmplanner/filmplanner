import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'mobx-react'

import MovieSelectorStore from 'stores/MovieSelectorStore'
import MovieSelectorApp from 'components/MovieSelectorApp'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('movie-selector-app')

  const app = (
    <Provider MovieSelectorStore={MovieSelectorStore}>
      <MovieSelectorApp/>
    </Provider>
  )

  ReactDOM.render(app, node)
})