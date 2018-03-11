defmodule Msg do
  
  def decode(<<id::16, flag::16, qdc::16, anc::16, nsc::16, arc::16, body::binary >>) do
    {id, flag, qdc, anc, nsc, arc, body}
  end

end