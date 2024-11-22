package boleta;

import com.itextpdf.kernel.color.Color;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class HeaderDetails {

    private String invoiceTitle = ConstantUtil.INVOICE_TITLE;
    private String invoiceNoText = ConstantUtil.INVOICE_NO_TEXT;
    private String invoiceDateText = ConstantUtil.INVOICE_DATE_TEXT;
    private String invoiceNo = ConstantUtil.EMPTY;
    private String invoiceDate = ConstantUtil.EMPTY;
    private Color borderColor = Color.GRAY;

    public HeaderDetails setInvoiceTitle(String tituloFactura) {
        this.invoiceTitle = tituloFactura;
        return this;
    }

    public HeaderDetails setInvoiceNoText(String facturaNoText) {
        this.invoiceNoText = facturaNoText;
        return this;
    }

    public HeaderDetails setInvoiceDateText(String facturaFechaText) {
        this.invoiceDateText = facturaFechaText;
        return this;
    }

    public HeaderDetails setInvoiceNo(String facturaNo) {
        this.invoiceNo = facturaNo;
        return this;
    }

    public HeaderDetails setInvoiceDate(String facturaFecha) {
        this.invoiceDate = facturaFecha;
        return this;
    }

    public HeaderDetails setBorderColor(Color colorBorde) {
        this.borderColor = colorBorde;
        return this;
    }

    public HeaderDetails build() {
        return this;
    }

    public String getInvoiceTitle() {
        return invoiceTitle;
    }

    public String getInvoiceNoText() {
        return invoiceNoText;
    }

    public String getInvoiceDateText() {
        return invoiceDateText;
    }

    public String getInvoiceNo() {
        return invoiceNo;
    }

    public String getInvoiceDate() {
        return invoiceDate;
    }

    public Color getBorderColor() {
        return borderColor;
    }
    
    
}
