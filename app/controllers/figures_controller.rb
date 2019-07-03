class FiguresController < ApplicationController

  get '/figures/new' do

    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"

  end

  get '/figures' do

    @figures = Figure.all
    erb :"/figures/index"

  end

  post '/figures' do

    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.create(:name => params[:figure][:name])
    if !@title[:name].empty?
      t = Title.create(:name => @title[:name])
      @figure.titles.push(t)
    end
    if @title_ids
      @title_ids.each do |id|
        t = Title.find(id)
        @figure.titles.push(t)
      end
    end
    if !@landmark[:name].empty?
      l = Landmark.create(:name => @landmark[:name])
      @figure.landmarks.push(l)
    end
    if @landmark_ids
      @landmark_ids.each do |id|
        l = Landmark.find(id)
        @figure.landmarks.push(l)
      end
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
