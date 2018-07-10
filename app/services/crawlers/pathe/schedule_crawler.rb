module Crawlers
  module Pathe
    class ScheduleCrawler < BaseCrawler
      def path
        theater_ids = @options[:theater_ids].join(',')
        date        = @options[:date].strftime('%d-%m-%Y')

        "/update-schedule/#{theater_ids}/#{date}"
      end

      def crawl
        {
          movies: movies
        }
      end

      before :crawl, call: :timeout

      private

      def movies
        movies = page.css('.schedule__section')

        movies.map do |movie|
          {
            id:           movie.find('.schedule__figure a', 'data-gtmclick'),
            title:        movie.find('.schedule__figure a', 'title'),
            description:  movie.find('.schedule__synopsis'),
            image:        movie.find('.schedule__figure img', 'src'),
            url:          movie.find('.schedule__figure a', 'href'),
            theaters:     theaters(movie)
          }
        end
      end

      def theaters(movie)
        theaters = movie.css('.schedule__location')

        theaters.each_with_index.map do |theater, index|
          {
            name:   theater.to_s,
            shows:  shows(movie, index)
          }
        end
      end

      def shows(movie, theater_index)
        theater = movie.css('.schedule__container')[theater_index]
        shows   = theater.css('.schedule-time')

        shows.map do |show|
          {
            date:     @options[:date],
            start_at: show.find('.schedule-time__start'),
            end_at:   show.find('.schedule-time__end'),
            version:  show.find('.schedule-time__label'),
            url:      show.attribute('data-href')
          }
        end
      end
    end
  end
end
