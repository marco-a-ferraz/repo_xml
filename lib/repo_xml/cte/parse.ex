defmodule RepoXml.Cte.Parse do
  import SweetXml

  def call(%{xml_b64: xml_b64} = params) do
    xml_b64
    |> Base.decode64!(ignore: :whitespace)
    |> xpath(~x"//infCte",
      number: ~x"//nCT/text()"s,
      emission_date: ~x"//dhEmi/text()"s,
      modal: ~x"//modal/text()"i,
      issuer_name: ~x"//emit/xNome/text()"s,
      issuer_cnpj: ~x"//emit/CNPJ/text()"s,
      sender_name: ~x"//rem/xNome/text()"s,
      sender_cnpj: ~x"//rem/CNPJ/text()"s,
      receiver_name: ~x"//dest/xNome/text()"s,
      receiver_cnpj: ~x"//dest/CNPJ/text()"s,
      dispatcher_name: ~x"//exped/xNome/text()"s,
      dispatcher_cnpj: ~x"//exped/CNPJ/text()"s,
      recipient_name: ~x"//receb/xNome/text()"s,
      recipient_cnpj: ~x"//receb/CNPJ/text()"s,
      merchandise_value: ~x"//vCarga/text()"s,
      service_value: ~x"//vTPrest/text()"s,
      type_service: ~x"//tpServ/text()"i,
      type: ~x"//tpServ/text()"i,
      weight: ~x"//infQ/qCarga/text()"sl
    )
    |> Map.update(:weight, 0, fn array -> set_weight(array) end)
    |> Map.merge(params)
  end

  defp set_weight(array) do
    case length(array) do
      0 -> 0
      _ -> hd(array)
    end
  end

  # quantity and borrowers
  defp set_borrowers do

  end
end
