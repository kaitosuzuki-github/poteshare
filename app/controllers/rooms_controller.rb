class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      if params[:room][:image]
        @room.image_name = "#{@room.id}.jpg"
        image = params[:room][:image]
        File.binwrite("public/room_images/#{@room.image_name}", image.read)
        if @room.update(image_name: @room.image_name)
          flash[:notice] = "ルームを登録しました"
          redirect_to root_path
        else
          render new_room_path
        end
      else
        flash[:notice] = "ルームを登録しました"
        redirect_to root_path
      end
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @book = Book.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if params[:room][:image]
        @room.image_name = "#{@room.id}.jpg"
        image = params[:room][:image]
        File.binwrite("public/room_images/#{@room.image_name}", image.read)
    end
    if @room.update(room_params)
      flash[:notice] = "ルームを登録しました"
      redirect_to rooms_path
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "ルームを削除しました"
    redirect_to rooms_path
  end

  def search
    @rooms = Room.search(params[:area], params[:keyword])
  end
end

private

def room_params
  params.require(:room).permit(:name, :introduction, :price, :address, :user_id)
end
