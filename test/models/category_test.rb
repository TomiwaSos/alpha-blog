require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

    def setup
        @category = Category.new(name: 'sports')
    end 

   test "Category should be valid" do
       assert @category.valid? 
   end

   test 'Name should be present' do 
        @category.name = ' '
        assert_not @category.valid? 
   end 

   test 'name should be unique' do 
        @category.save 
        @category2 = Category.new(name: 'sports')
        assert_not @category2.valid?

   end 

   test 'name shouldnt be too long' do 
        @category.name = 'a' * 26
        assert_not @category.valid?
   end 

   test 'name shouldnt be too short' do 
        @category.name = 'a' * 2
        assert_not @category.valid?

   end 


end