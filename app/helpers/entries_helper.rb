module EntriesHelper

  def entry_params
    params.require(:entry).permit(:title, :subhead, :body)
  end

end
