class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    # 新規チャットを保存するために「空のレコード」と「ルームのid」を用意しなければならない。
  end

  def create
    @room = Room.find(params[:room_id])
    # roomsテーブルからroom_idを取得。
    @message = @room.messages.new(message_params)
    # room_idに紐づいたメッセージのインスタンスを生成。
    # message_paramsを引数にして、privateメソッドを呼び出す。
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
