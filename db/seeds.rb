# This file should ensure the existence of records required to run the application in every environment (production,# Create sample articles
articles = [
  {
    title: "Getting Started with Ruby on Rails",
    content: "Ruby on Rails is a web application framework that includes everything needed to create database-backed web applications according to the Model-View-Controller (MVC) pattern.\n\nIt emphasizes the use of well-known software engineering patterns and principles, such as convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.\n\nThis makes it both powerful and beginner-friendly!"
  },
  {
    title: "The Power of Hotwire in Modern Rails",
    content: "Hotwire is the default frontend framework for Rails 7, bringing the speed of a single-page application without the complexity of a heavy JavaScript framework.\n\nIt consists of three main parts:\n- Turbo Drive\n- Turbo Frames\n- Turbo Streams\n\nThis combination allows for dynamic, responsive applications while keeping the simplicity Rails is known for."
  },
  {
    title: "Writing Clean Ruby Code",
    content: "Clean code is not just about making your code work - it's about making it work well and be maintainable.\n\nSome key principles for writing clean Ruby code:\n1. Use meaningful names\n2. Keep methods small and focused\n3. Follow the Single Responsibility Principle\n4. Write descriptive tests\n\nRemember: Code is read more often than it is written!"
  }
]

articles.each do |article_data|
  article = Article.create!(article_data)

  # Add some comments to each article
  rand(2..4).times do
    article.comments.create!(
      content: [
        "Great article! Thanks for sharing.",
        "This was really helpful. Looking forward to more content like this.",
        "Interesting perspective. I learned a lot from this.",
        "Well written and easy to understand.",
        "Thanks for breaking this down so clearly."
      ].sample
    )
  end
end

puts "Seed data created successfully!"
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
