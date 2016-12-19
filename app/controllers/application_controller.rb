require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
   erb :new
  end

  get '/posts/:id/edit' do
    @post = Post.find(params["id"].to_i)
    erb :edit
  end

  get '/posts/:id' do
    @post = Post.find(params["id"].to_i)
    erb :show
  end

  get '/posts' do
    @id = nil
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    new_post = Post.new(name: params["post_name"], content: params["post_content"])
    new_post.save
    @posts = Post.all
    erb :index
  end

  patch '/posts/:id' do
    @post = Post.find(params["id"].to_i)
    @post.name=(params["post_name"])
    @post.content=(params["post_content"])
    @post.save
    erb :show
  end

  delete '/posts/:id/delete' do
    @id = params["id"].to_i
    Post.delete(@id)
    @posts = Post.all
    erb :index
  end

end
