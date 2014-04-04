require 'spec_helper'

describe Seeders::CategoriesSeeder do
  it 'should seed categories' do
    previous_count = Category.count
    category_count = Seeders::CategoriesSeeder.categories.length
    Seeders::CategoriesSeeder.seed
    expect(Category.count).to eql(previous_count + category_count)
  end

  it 'should not duplicate categories' do
    previous_count = Category.count
    category_count = Seeders::CategoriesSeeder.categories.length
    Seeders::CategoriesSeeder.seed
    expect(Category.count).to eql(previous_count + category_count)
    Seeders::CategoriesSeeder.seed
    expect(Category.count).to eql(previous_count + category_count)
  end
end
