require 'simplecov'
SimpleCov.start
gem "minitest","~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < MiniTest::Test

  attr_reader :item_repo,
              :filename,
              :engine

  def setup
    @filename = "./test/data"
    @engine = SalesEngine.new(filename)
    @item_repo = ItemRepository.load_csvs("#{filename}/items.csv", engine)
  end

  def test_it_will_know_its_parent
    assert_equal engine, item_repo.sales_engine
  end

  def test_it_will_return_all_of_the_item_objects
    assert_equal 100, item_repo.all.count
  end

  def test_it_will_return_a_random_item
    assert_equal false, item_repo.random == item_repo.random
  end

  def test_it_will_find_items_by_id
    assert_equal 1, item_repo.find_by_id(1).id
  end

  def test_it_will_find_items_by_name
    assert_equal "Item Qui Esse", item_repo.find_by_name("Item Qui Esse").name
  end

  def test_it_will_find_items_by_description
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item_repo.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.").description
  end

  def test_it_will_find_items_unit_price
    assert_equal 75107, item_repo.find_by_unit_price(75107).unit_price
  end

  def test_it_will_find_merchant_id
    assert_equal 1, item_repo.find_by_merchant_id(1).merchant_id
  end

  def test_it_will_find_when_item_was_created_at
    assert_equal "2012-03-27 14:53:59 UTC", item_repo.find_by_created_at("2012-03-27 14:53:59 UTC").created_at
  end

  def test_it_will_find_when_item_was_updated_at
    assert_equal "2012-03-27 14:53:59 UTC", item_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").updated_at
  end

  def test_it_will_find_all_items_by_id
    assert_equal 1, item_repo.find_all_by_id(1).count
  end

  def test_it_will_find_all_items_by_name
    assert_equal 1, item_repo.find_all_by_name("Item Ea Voluptatum").count
  end

  def test_it_will_find_all_items_by_description
    assert_equal 1, item_repo.find_all_by_description("Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.").count
  end

  def test_it_will_find_all_items_by_unit_price
    assert_equal 1, item_repo.find_all_by_unit_price(32301).count
  end

  def test_it_will_find_all_items_by_merchant_id
    assert_equal 15, item_repo.find_all_by_merchant_id(1).count
  end

  def test_it_will_find_all_items_by_created_at
    assert_equal 100, item_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_will_find_all_items_by_updated_at
    assert_equal 100, item_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end
end
