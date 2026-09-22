# aguia-stirling

Imagem Docker customizada do **Stirling PDF** para conversão de `.docx` em PDF dentro de um pipeline n8n de geração de apostilas.

A imagem oficial do Stirling não traz o módulo de fórmulas do LibreOffice, o que fazia equações matemáticas (OMML) sumirem do PDF final. Este `Dockerfile` resolve isso e adiciona as fontes necessárias.

## O que muda em relação à imagem oficial

- Instala **`libreoffice-math`** (com retry e correção de `postinst` quebrado, porque a imagem base tem o `dpkg` em estado parcial).
- Copia as fontes de `fonts/` para `/usr/share/fonts/custom/` e roda `fc-cache`.
- Verifica no build que `libsmlo.so` existe; sem ele a imagem não passa.

## Uso

```bash
docker build -t aguia-stirling .
docker run -p 8080:8080 aguia-stirling
curl -F "fileInput=@apostila.docx" http://localhost:8080/api/v1/convert/file/pdf -o apostila.pdf
```

No Easypanel: App > Dockerfile, porta interna 8080. O n8n chama por `http://<projeto>_stirlingpdf:8080/api/v1/convert/file/pdf`.

## Atenção sobre fontes

Só coloque em `fonts/` as fontes que **não** estão embutidas nos DOCX. Fonte instalada no sistema tem prioridade sobre fonte embutida no documento; uma família parcial (sem Regular ou Bold) força pesos errados na conversão. No pipeline original as fontes da marca ficam embutidas pelo renderizador ([renderdocxs](https://github.com/willianbrognoli/renderdocxs)) e esta pasta fica só com fontes de apoio.

## Stack

Stirling PDF · LibreOffice Writer + Math · Docker
