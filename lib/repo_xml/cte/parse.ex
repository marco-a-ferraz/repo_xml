defmodule RepoXml.Cte.Parse do
  import SweetXml

  def call(struct) do
    Base.decode64(struct.xml_b64)
    |> xmap(key: ~x"//infCte/@Id")
  end
end