class BooksController < ApplicationController
  def index
    @books = current_user.books
  end

  def create
    @book = Book.new(book_params)
    @room = Room.find(params[:book][:room_id])
    if @book.save
      flash[:notice] = "予約を完了しました"
      redirect_to root_path
    else
      render "rooms/show"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "予約をキャンセルしました"
    redirect_to books_path
  end

  def confirm
    @book = Book.new(book_params)
    @room = Room.find(params[:book][:room_id])
    if @book.valid?
      @stay_days = (@book.check_out - @book.check_in).to_i
      @total_price = @room.price * @stay_days * @book.people_num
    else
      render "rooms/show"
    end
  end
end

private

def book_params
  params.require(:book).permit(:check_in, :check_out, :people_num, :user_id, :room_id)
end
