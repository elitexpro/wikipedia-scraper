require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get '/'
    assert_response :success
    assert_select 'form'
  end

  test 'should scrape Wikipedia article' do
    get '/scrape', params: { wikipedia_link: 'https://en.wikipedia.org/wiki/Main_Page' }
    assert_response :success
    assert_select 'h2', 'Title: Ruby on Rails'
    assert_select 'h3', 'Languages:'
    assert_select 'li', 'Afrikaans'
  end

  test 'should display error for invalid Wikipedia link' do
    get '/scrape', params: { wikipedia_link: 'invalid_link' }
    assert_response :success
    assert_select 'p', 'No data to display.'
    assert_select '.alert.alert-danger', 'Invalid Wikipedia link!'
  end
end
