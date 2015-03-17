require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/parser'

class ItemTest < MiniTest::Test 

  attr_reader :filename,
              :engine,
              :item_repository

  def setup
    @filename = "./test/data"
    @engine = SalesEngine.new(filename)
    @item_repository = ItemRepository.load_csvs("#{filename}/items.csv", engine)
  end

  def test_it_knows_its_parent
    assert_equal item_repository, item_repository.items.first.repo
  end

  def test_it_has_attributes_associated_with_the_item
    item = item_repository.items.first
    assert_equal 1, item.id 
    assert_equal "Item Qui Esse", item.name
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item.description
    assert_equal 75107, item.unit_price
    assert_equal 1, item.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
  end

  def test_repo_finds_invoice_items_by_item
    repo = MiniTest::Mock.new
    item = Item.new({},repo)
    repo.expect(:find_invoice_items, [539],[0])
    assert_equal [539], item.invoice_items 
    repo.verify
  end

  def test_repo_finds_merchants_by_item
    repo = MiniTest::Mock.new
    item = Item.new({},repo)
    repo.expect(:find_merchant, "Schroeder-Jerde", [0])
    assert_equal "Schroeder-Jerde", item.merchant 
    repo.verify
  end
end