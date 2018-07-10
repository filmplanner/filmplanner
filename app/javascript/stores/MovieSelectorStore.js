import { observable, action, computed } from 'mobx'

class MovieSelectorStore {
  @observable theaters    = [];
  @observable movies      = [];
  @observable shows       = [];
  @observable suggestions = [];
}

const store = new MovieSelectorStore();
export default store;
