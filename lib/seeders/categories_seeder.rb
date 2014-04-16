module Seeders
  module CategoriesSeeder
    class << self
      def seed
        categories.each do |category|
          Category.find_or_create_by(name: category)
        end
      end

      def categories
        %w(
          Hobbies Family&Friends Work Education Relaxation Exercise
          )
      end
    end
  end
end
