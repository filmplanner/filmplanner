import { observable, action, computed } from 'mobx'

import { url } from 'lib/url'

class MovieSelectorStore {
  @observable dates;
  @observable theaters;
  @observable movies;
  @observable shows;
  @observable suggestions;

  @observable selectedDate;
  @observable selectedTheaterIds;
  @observable selectedMovieIds;
  @observable selectedSuggestionKey;

  constructor() {
    this.loadSelection();

    this.loadDateData();
    this.loadTheaterData();
    this.loadMovieData();
    this.loadSuggestionData();
  }

  @action
  loadSelection() {
    this.selectedDate         = new Date();
    this.selectedTheaterIds   = [12];
  }

  @action
  loadDateData() {
    fetch('/api/dates')
      .then(response => response.json())
      .then(data => this.setDateData(data))
      .catch(error => console.error("Couldn't fetch dates", error))
  }

  @action
  loadTheaterData() {
    fetch('/api/theaters')
      .then(response => response.json())
      .then(data => this.setTheaterData(data))
      .catch(error => console.error("Couldn't fetch theaters", error))
  }

  @action
  loadMovieData() {
    fetch(url('/api/movies', { theater_ids: this.selectedTheaterIds, date: this.selectedDate }))
      .then(response => response.json())
      .then(data => this.setMovieData(data))
      .catch(error => console.error("Couldn't fetch movies", error))
  }

  @action
  loadSuggestionData() {
    fetch(url('/api/suggestions', { theater_ids: this.selectedTheaterIds, date: this.selectedDate, movie_ids: this.selectedMovieIds }))
      .then(response => response.json())
      .then(data => this.setSuggestionData(data))
      .catch(error => console.error("Couldn't fetch suggestions", error))
  }

  @action
  setDateData(data) {
    this.dates = data
  }

  @action
  setTheaterData(data) {
    this.theaters = data
  }

  @action
  setMovieData(data) {
    this.movies = data.movies;
    this.shows  = data.shows;
  }

  @action
  setSuggestionData(data) {
    this.suggestions = data;
  }
}

const store = new MovieSelectorStore();
export default store;
