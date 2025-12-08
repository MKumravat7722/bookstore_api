Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://book-store-front-end-jlpm.onrender.com'
    # https://book-store-front-end-jlpm.onrender.com
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization']
  end
end
