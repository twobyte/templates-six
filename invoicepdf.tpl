<?php
$pdf->SetMargins(20, 12, 20);

# Logo
//$logoFilename = 'placeholder.png';

if ( file_exists(ROOTDIR . '/assets/img/tastydigital-logo-grn.png')) {
	$logoFilename = 'tastydigital-logo-grn.png';
	$pdf->Image(ROOTDIR . '/assets/img/' . $logoFilename, 16.5, 21.5, 57.15, 20.46);
}else{
	if (file_exists(ROOTDIR . '/assets/img/logo.png')) {
	    $logoFilename = 'logo.png';
	} elseif (file_exists(ROOTDIR . '/assets/img/logo.jpg')) {
	    $logoFilename = 'logo.jpg';
	}
	$pdf->Image(ROOTDIR . '/assets/img/' . $logoFilename, 15, 25, 75);
}
$pageWidth    = $pdf->getPageWidth();

# top line 
//$pdf->SetLineStyle(array('width' => 0, 'cap' => 'butt', 'join' => 'miter', 'dash' => 4, 'color' => array(255, 0, 0)));
//$pdf->SetFillColor(255,255,128);
//$pdf->Rect(20, 12, 168, 1.768, 0, 0, array(161,168,171));
$style = array('width' => 1, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(161,168,171));
$pdf->Line(20, 12.9, $pageWidth-20, 12.9, $style);

//require_once('/your_path_to/tcpdf.php');
//$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
//$proximaBold = TCPDF_FONTS::addTTFfont(ROOTDIR . '/assets/fonts/proxima-nova/proximanova-bold-webfont.ttf','TrueType');
//$proximaLight = TCPDF_FONTS::addTTFfont(ROOTDIR . '/assets/fonts/proxima-nova/proximanova-light-webfont.ttf','TrueType');
//$proximaLight = $pdf->addTTFfont(ROOTDIR . '/assets/fonts/proxima-nova/proximanova-light-webfont.ttf');


# Invoice Status
$pdf->SetXY(80, 20);
$pdf->SetFont($pdfFont, 'B', 13);
$pdf->setCellHeightRatio(1.4);
$pdf->setFontSpacing(0.2);
$pdf->SetTextColor(161,168,171);
$pdf->Cell(0, 6, strtoupper($companyname), 0, 1, 'R', false);
//$pdf->SetTextColor(255);
//$pdf->SetLineWidth(0);
//$pdf->StartTransform();
//$pdf->Rotate(-35, 100, 225);
if ($status == 'Draft') {
    $pdf->SetTextColor(200);
    //$pdf->SetDrawColor(140);
} elseif ($status == 'Paid') {
    $pdf->SetTextColor(151, 215, 0);
    //$pdf->SetDrawColor(110, 192, 70);
} elseif ($status == 'Cancelled') {
    $pdf->SetTextColor(200);
    //$pdf->SetDrawColor(140);
} elseif ($status == 'Refunded') {
    $pdf->SetTextColor(131, 182, 218);
    //$pdf->SetDrawColor(91, 136, 182);
} elseif ($status == 'Collections') {
    $pdf->SetTextColor(3, 3, 2);
    //$pdf->SetDrawColor(127);
} else {
    $pdf->SetTextColor(223, 85, 74);
    //$pdf->SetDrawColor(171, 49, 43);
}
//$pdf->setPageUnit('mm');
//$pdf->setFontSpacing(1);
$pdf->Cell(0, 6, '('.strtoupper(Lang::trans('invoices' . strtolower($status))).')', 0, 1, 'R', false);
$pdf->setFontSpacing(0);
//$pdf->StopTransform();
$pdf->SetTextColor(68,68,68);

$leftColWidth = 41.6;
$cellHeight = 4;
# Company Details
$pdf->SetXY(20, 55);
$pdf->SetFont($pdfFont, '', 26);
$pdf->Cell($leftColWidth, 6, strtoupper('INVOICE'), 0, 1, 'L');
$pdf->Ln(4);

$pdf->SetFont($pdfFont, '', 9);

$contactData = '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#7bbb42;">+44 (0)20 7097 3830 <br>
<a href="mailto:billing@tastydigital.com" style="color:#7bbb42;">billing@tastydigital.com</a></p>';
$contactData .= '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#5a5a5a;">'.$companyname.'<br>';
$contactData .= 'Wimbletech Library, <br>
35 Wimbledon Hill Road <br>
London SW19 7NB</p>';
$contactData .= '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#5a5a5a;">Registered in <br>
England &amp; Wales</p>';
$contactData .= '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#5a5a5a;">Company registration number: 09474918</p>';

/*$pdf->Cell($leftColWidth, $cellHeight, '+44 (0)20 7097 3830', 0, 1, 'L');
$pdf->Cell($leftColWidth, $cellHeight, 'billing@tastydigital.com', 0, 1, 'L');
$pdf->Ln(4);
$pdf->MultiCell($leftColWidth, 6, $companyname .'
Wimbletech Library,  
35 Wimbledon Hill Road
London SW19 7NB', 0, 'L');
$pdf->Ln(4);
$pdf->MultiCell($leftColWidth, 6, 'Registered in 
England & Wales', 0, 'L');
$pdf->Ln(4);
$pdf->MultiCell($leftColWidth, 6, 'Company registration number: 09474918', 0, 'L'); */

$pdf->writeHTMLCell($leftColWidth, 6, '', '', $contactData, 0, 1, false, true, 'L');
//INVOICE

# Header Bar

/**
 * Invoice header
 *
 * You can optionally define a header/footer in a way that is repeated across page breaks.
 * For more information, see http://docs.whmcs.com/PDF_Invoice#Header.2FFooter
 */
$leftColSpace = 66.67;
$pdf->SetLeftMargin($leftColSpace);
$pdf->SetXY($leftColSpace, 57);
//$pdf->SetFont($pdfFont, 'B', 15);
//$pdf->SetFillColor(239);
$pdf->SetFont($pdfFont, '', 9);
$customerhtml = '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#333333;">';
if ($clientsdetails["companyname"]) {
	$customerhtml .= '<strong>'.Lang::trans('invoicesattn') . ':</strong> ' . $clientsdetails["firstname"] . ' ' . $clientsdetails["lastname"] . '<br>'.$clientsdetails["companyname"].'<br>';
	
    //$pdf->writeHTML('<strong>'.Lang::trans('invoicesattn') . ':</strong> ' . $clientsdetails["firstname"] . ' ' . $clientsdetails["lastname"], true, false, false, false, 'L');
    //$pdf->writeHTML($clientsdetails["companyname"], true, false, false, false, 'L');
} else {
	$customerhtml .= $clientsdetails["firstname"] . ' ' . $clientsdetails["lastname"].'<br>';
	//$pdf->writeHTML($clientsdetails["firstname"] . ' ' . $clientsdetails["lastname"], true, false, false, false, 'L');
}
$customerhtml .= $clientsdetails["address1"].'<br>';
//$pdf->writeHTML($clientsdetails["address1"], true, false, false, false, 'L');
if ($clientsdetails["address2"]) {
	$customerhtml .= $clientsdetails["address2"].'<br>';
    //$pdf->writeHTML($clientsdetails["address2"], true, false, false, false, 'L');
}
$customerhtml .= $clientsdetails["city"] . ", " . $clientsdetails["state"] . ", " . $clientsdetails["postcode"].'<br>';
//$pdf->writeHTML($clientsdetails["city"] . ", " . $clientsdetails["state"] . ", " . $clientsdetails["postcode"], true, false, false, false, 'L');
if ($clientsdetails["country"]) {
	$customerhtml .= $clientsdetails["country"].'<br>';
	//$pdf->writeHTML($clientsdetails["country"], true, false, false, false, 'L');
}
$customerhtml .= '</p>';

$pdf->writeHTML($customerhtml, true, false, false, false, 'L');

if ($customfields) {
    //$pdf->Ln();
    $cstm = '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#333333;">';
    foreach ($customfields as $customfield) {
        $cstm .= '<strong>'.$customfield['fieldname'] . ':</strong> ' . $customfield['value'];
    }
    $pdf->writeHTML($cstm.'</p>', true, false, false, false, 'L');
}
//$pdf->Ln(4);

$specifics = '<p style="line-height: 1.5;margin-bottom: 1em; font-size:9pt;color:#333333;">';
//$pdf->MultiCell(0, 8, $pagetitle, 0, 'L', true);
$specifics .= '<strong>'.Lang::trans('invoicesdatecreated') . ':</strong> ' . $datecreated . '<br>';
//$pdf->MultiCell(0, $cellHeight, Lang::trans('invoicesdatedue') . ': ' . $duedate, 0, 'L');
//$pdf->MultiCell(0, $cellHeight, $companyname, 0, 'L');

$specifics .= '<strong>'.Lang::trans('invoicenumber') . ':</strong> '.sprintf("%'.05d\n", $invoicenum) . '<br>';

if ($status == "Paid"){
	$specifics .= '<strong>'.Lang::trans('paymentmethod') . ':</strong> '.$paymentmethod . '<br>';
    $specifics .= '<strong>Date Paid:</strong> '. $datepaid;
}else{
	$specifics .= '<strong>Terms:</strong> 14 days ('.$duedate.')';
	
	
}
$pdf->writeHTML($specifics.'</p>', true, false, false, false, 'L');
//$pdf->MultiCell(0, $cellHeight, 'Reference: '.$invoiceid, 0, 'L');
$pdf->Ln(6);
                        
                        
$startpage = $pdf->GetPage();

# Clients Details
//$addressypos = $pdf->GetY();
//$pdf->SetFont($pdfFont, 'B', 10);
//$pdf->MultiCell(0, 4, Lang::trans('invoicesinvoicedto'), 0, 'L');
//$pdf->SetFont($pdfFont, '', 10);


# Invoice Items
$tblhtml = '<table width="100%" bgcolor="#ccc" cellspacing="1" cellpadding="2" border="0">
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;text-align:center;">
        <td width="80%">' . Lang::trans('invoicesdescription') . '</td>
        <td width="20%">' . Lang::trans('quotelinetotal') . '</td>
    </tr>';
foreach ($invoiceitems as $item) {
    $tblhtml .= '
    <tr bgcolor="#fff">
        <td align="left">' . nl2br($item['description']) . '<br /></td>
        <td align="center">' . $item['amount'] . '</td>
    </tr>';
}
$tblhtml .= '
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td align="right">' . Lang::trans('invoicessubtotal') . '</td>
        <td align="center">' . $subtotal . '</td>
    </tr>';
if ($taxname) {
    $tblhtml .= '
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td align="right">' . $taxrate . '% ' . $taxname . '</td>
        <td align="center">' . $tax . '</td>
    </tr>';
}
if ($taxname2) {
    $tblhtml .= '
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td align="right">' . $taxrate2 . '% ' . $taxname2 . '</td>
        <td align="center">' . $tax2 . '</td>
    </tr>';
}
$tblhtml .= '
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td align="right">' . Lang::trans('invoicescredit') . '</td>
        <td align="center">' . $credit . '</td>
    </tr>
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td align="right">' . Lang::trans('invoicestotal') . '</td>
        <td align="center">' . $total . '</td>
    </tr>
</table>';

$pdf->writeHTML($tblhtml, true, false, false, false, '');

$pdf->Ln(2);


# Transactions
$pdf->SetFont($pdfFont, 'B', 9);
$pdf->MultiCell(0, 4, Lang::trans('invoicestransactions'), 0);

$pdf->Ln(4);

$pdf->SetFont($pdfFont, '', 9);

$tblhtml = '<table width="100%" bgcolor="#ccc" cellspacing="1" cellpadding="2" border="0">
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;text-align:center;">
        <td width="25%">' . Lang::trans('invoicestransdate') . '</td>
        <td width="25%">' . Lang::trans('invoicestransgateway') . '</td>
        <td width="30%">' . Lang::trans('invoicestransid') . '</td>
        <td width="20%">' . Lang::trans('invoicestransamount') . '</td>
    </tr>';

if (!count($transactions)) {
    $tblhtml .= '
    <tr bgcolor="#fff">
        <td colspan="4" align="center">' . Lang::trans('invoicestransnonefound') . '</td>
    </tr>';
} else {
    foreach ($transactions AS $trans) {
        $tblhtml .= '
        <tr bgcolor="#fff">
            <td align="center">' . $trans['date'] . '</td>
            <td align="center">' . $trans['gateway'] . '</td>
            <td align="center">' . $trans['transid'] . '</td>
            <td align="center">' . $trans['amount'] . '</td>
        </tr>';
    }
}
$tblhtml .= '
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td colspan="3" align="right">' . Lang::trans('invoicesbalance') . '</td>
        <td align="center">' . $balance . '</td>
    </tr>
</table>';

$pdf->writeHTML($tblhtml, true, false, false, false, '');

# Notes
if ($notes) {
    $pdf->Ln(4);
    $pdf->SetFont($pdfFont, '', 8);
    $pdf->MultiCell(170, 5, Lang::trans('invoicesnotes') . ': ' . $notes);
}
$pdf->SetFont($pdfFont, '', 9);
$thanks = 'Thank you for using <strong>Tasty Digital Ltd.</strong>';
$pdf->writeHTML($thanks, true, false, false, false, 'L');
//$pdf->Ln(4);
if ($status == 'Draft' || $status == "Unpaid") {
	foreach ($companyaddress as $addressLine) {
	    $pdf->writeHTML(trim($addressLine), true, false, false, false, 'L');
	    //$pdf->SetFont($pdfFont, '', 9);
	}
}
$pdf->Ln(5);

# Generation Date
/**
$pdf->SetFont($pdfFont, '', 8);
$pdf->Ln(4);
$pdf->Cell(0, 4, Lang::trans('invoicepdfgenerated') . ' ' . getTodaysDate(1), '', '', 'L');


 * Invoice footer
 */
