<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$companyname} - {$pagetitle}</title>
	
	{literal}
	<script>
	  (function(d) {
	    var config = {
	      kitId: 'ovp5bbk',
	      scriptTimeout: 3000,
	      async: true
	    },
	    h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)
	  })(document);
	</script>
	{/literal}

    <!-- Bootstrap -->
    <link href="{$BASE_PATH_CSS}/bootstrap.min.css" rel="stylesheet">
    <link href="{$BASE_PATH_CSS}/font-awesome.min.css" rel="stylesheet">

    <!-- Styling -->
    <link href="templates/{$template}/css/overrides.css" rel="stylesheet">
    <link href="templates/{$template}/css/styles.css" rel="stylesheet">
    <link href="templates/{$template}/css/invoice.css" rel="stylesheet">

</head>
<body>

    <div class="container-fluid invoice-container">

        {if $invalidInvoiceIdRequested}

            {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoiceserror bodyTextCenter=true}

        {else}
			<hr c>
			
            <div class="row" style="margin-bottom: 35px;">
	            
                <div class="col-xs-4">
					
                    <h2 class="logo"><img src="/account/assets/img/tastydigital-logo-grn.png" title="{$companyname}" width="200" height="72" /></h2>
                 

                </div>
                <div class="col-xs-8 text-right">
                    <div class="invoice-status">
	                    <span class="company-name">{$companyname} <br></span>
                        {if $status eq "Draft"}
                            <span class="draft">({$LANG.invoicesdraft})</span>
                        {elseif $status eq "Unpaid"}
                            <span class="unpaid">({$LANG.invoicesunpaid})</span>
                        {elseif $status eq "Paid"}
                            <span class="paid">({$LANG.invoicespaid})</span>
                        {elseif $status eq "Refunded"}
                            <span class="refunded">({$LANG.invoicesrefunded})</span>
                        {elseif $status eq "Cancelled"}
                            <span class="cancelled">({$LANG.invoicescancelled})</span>
                        {elseif $status eq "Collections"}
                            <span class="collections">({$LANG.invoicescollections})</span>
                        {/if}
                    </div>

                    {if $status eq "Unpaid" || $status eq "Draft"}
                        <div class="small-text">
                            {$LANG.invoicesdatedue}: {$datedue}
                        </div>
                        <div class="payment-btn-container" align="center">
                            {$paymentbutton}
                        </div>
                    {/if}

                </div>
            </div>

            {if $paymentSuccess}
                {include file="$template/includes/panel.tpl" type="success" headerTitle=$LANG.success bodyContent=$LANG.invoicepaymentsuccessconfirmation bodyTextCenter=true}
            {elseif $pendingReview}
                {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.success bodyContent=$LANG.invoicepaymentpendingreview bodyTextCenter=true}
            {elseif $paymentFailed}
                {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoicepaymentfailedconfirmation bodyTextCenter=true}
            {elseif $offlineReview}
                {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.success bodyContent=$LANG.invoiceofflinepaid bodyTextCenter=true}
            {/if}

            <div class="row">
	            <div class="col-sm-3">
		             <h2 class="sidetitle">INVOICE</h2>
	            </div>
                <div class="col-sm-9">
                    <address class="small-text">
                        <strong>{$LANG['invoicesattn']}:</strong> {$clientsdetails.firstname} {$clientsdetails.lastname}<br />
                        {if $clientsdetails.companyname}{$clientsdetails.companyname}<br />{/if}
                        {if $clientsdetails.address1}{$clientsdetails.address1}<br />{/if}
                        {if $clientsdetails.address2}{$clientsdetails.address2}<br />{/if}
                        {if $clientsdetails.city}{$clientsdetails.city}<br />{/if}
                        {$clientsdetails.state}, {$clientsdetails.postcode}<br />
                        {if $clientsdetails.country}{$clientsdetails.country}<br />{/if}
                        {if $customfields}
                        {foreach from=$customfields item=customfield}
                        <strong>{$customfield.fieldname}:</strong> {$customfield.value}<br />
                        {/foreach}
                        {/if}
                    </address>
                    <p class="small-text">
                    	<strong>{$LANG.invoicesdatecreated}:</strong> {$date}<br>
	                    <strong>{$LANG.invoicenumber}:</strong> {"%05d"|sprintf:$invoicenum}<br>
                    	<strong>{$LANG.paymentmethod}:</strong>
                        {if $status eq "Unpaid" && $allowchangegateway}
                            <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}" class="form-inline">
                                {$gatewaydropdown}
                            </form>
                        {else}
                            {$paymentmethod}
                        {/if}<br>
                       {if $status eq "Paid"}
                        	<strong>Date Paid:</strong> {$datepaid}
                        {else}
                        	<strong>Terms:</strong> 14 days ({$duedate})
                        {/if}
                    </p>
                    
                    
		            <br />
		
		            {if $manualapplycredit}
		                <div class="panel panel-success">
		                    <div class="panel-heading">
		                        <h3 class="panel-title"><strong>{$LANG.invoiceaddcreditapply}</strong></h3>
		                    </div>
		                    <div class="panel-body">
		                        <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
		                            <input type="hidden" name="applycredit" value="true" />
		                            {$LANG.invoiceaddcreditdesc1} <strong>{$totalcredit}</strong>. {$LANG.invoiceaddcreditdesc2}. {$LANG.invoiceaddcreditamount}:
		                            <div class="row">
		                                <div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-4">
		                                    <div class="input-group">
		                                        <input type="text" name="creditamount" value="{$creditamount}" class="form-control" />
		                                        <span class="input-group-btn">
		                                            <input type="submit" value="{$LANG.invoiceaddcreditapply}" class="btn btn-success" />
		                                        </span>
		                                    </div>
		                                </div>
		                            </div>
		                        </form>
		                    </div>
		                </div>
		            {/if}
		
		            {if $notes}
		                {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.invoicesnotes bodyContent=$notes}
		            {/if}
		
		            <div class="panel panel-default">
		                <div class="panel-heading">
		                    <h3 class="panel-title"><strong>{$LANG.invoicelineitems}</strong></h3>
		                </div>
		                <div class="panel-body">
		                    <div class="table-responsive">
		                        <table class="table table-condensed">
		                            <thead>
		                                <tr>
		                                    <td><strong>{$LANG.invoicesdescription}</strong></td>
		                                    <td width="20%" class="text-center"><strong>{$LANG.invoicesamount}</strong></td>
		                                </tr>
		                            </thead>
		                            <tbody>
		                                {foreach from=$invoiceitems item=item}
		                                    <tr>
		                                        <td>{$item.description}{if $item.taxed eq "true"} *{/if}</td>
		                                        <td class="text-center">{$item.amount}</td>
		                                    </tr>
		                                {/foreach}
		                                <tr>
		                                    <td class="total-row text-right"><strong>{$LANG.invoicessubtotal}</strong></td>
		                                    <td class="total-row text-center">{$subtotal}</td>
		                                </tr>
		                                {if $taxrate}
		                                    <tr>
		                                        <td class="total-row text-right"><strong>{$taxrate}% {$taxname}</strong></td>
		                                        <td class="total-row text-center">{$tax}</td>
		                                    </tr>
		                                {/if}
		                                {if $taxrate2}
		                                    <tr>
		                                        <td class="total-row text-right"><strong>{$taxrate2}% {$taxname2}</strong></td>
		                                        <td class="total-row text-center">{$tax2}</td>
		                                    </tr>
		                                {/if}
		                                <tr>
		                                    <td class="total-row text-right"><strong>{$LANG.invoicescredit}</strong></td>
		                                    <td class="total-row text-center">{$credit}</td>
		                                </tr>
		                                <tr>
		                                    <td class="total-row text-right"><strong>{$LANG.invoicestotal}</strong></td>
		                                    <td class="total-row text-center">{$total}</td>
		                                </tr>
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
		            </div>
		
		            {if $taxrate}
		                <p class="small-text">* {$LANG.invoicestaxindicator}</p>
		            {/if}
		
		            <div class="transactions-container small-text">
		                <div class="table-responsive">
		                    <table class="table table-condensed">
		                        <thead>
		                            <tr>
		                                <td class="text-center"><strong>{$LANG.invoicestransdate}</strong></td>
		                                <td class="text-center"><strong>{$LANG.invoicestransgateway}</strong></td>
		                                <td class="text-center"><strong>{$LANG.invoicestransid}</strong></td>
		                                <td class="text-center"><strong>{$LANG.invoicestransamount}</strong></td>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            {foreach from=$transactions item=transaction}
		                                <tr>
		                                    <td class="text-center">{$transaction.date}</td>
		                                    <td class="text-center">{$transaction.gateway}</td>
		                                    <td class="text-center">{$transaction.transid}</td>
		                                    <td class="text-center">{$transaction.amount}</td>
		                                </tr>
		                            {foreachelse}
		                                <tr>
		                                    <td class="text-center" colspan="4">{$LANG.invoicestransnonefound}</td>
		                                </tr>
		                            {/foreach}
		                            <tr>
		                                <td class="text-right" colspan="3"><strong>{$LANG.invoicesbalance}</strong></td>
		                                <td class="text-center">{$balance}</td>
		                            </tr>
		                        </tbody>
		                    </table>
		                </div>
		            </div>
						<p class="small-text">
							Thank you for using <strong style="font-style: italic">{$companyname}</strong>
							{if $status eq "Unpaid" || $status eq "Draft"}<br>
								{$payto}
							{/if}
						</p>
					 <br>
		        </div>
		                
		                
		        <div class="col-sm-3 company-contact">
		            <address class="small-text">
		            
		                <p style="">+44 (0)20 7097 3830<br>
						<a href="mailto:billing@tastydigital.com">billing@tastydigital.com</a></p>
						
						<p>{$companyname}<br>
						Wimbletech Library,  <br>
						35 Wimbledon Hill Road<br>
						London SW19 7NB</p>
						
						<p>Registered in <br class="hidden-xs">England &amp; Wales</p>
						
						<p>Company registration number: 09474918</p>
					
		            </address>
					
		        </div>
		    </div>
		
		    <div class="pull-right btn-group btn-group-sm hidden-print">
		        <a href="javascript:window.print()" class="btn btn-default"><i class="fa fa-print"></i> {$LANG.print}</a>
		        <a href="dl.php?type=i&amp;id={$invoiceid}" class="btn btn-default"><i class="fa fa-download"></i> {$LANG.invoicesdownload}</a>
		    </div>

        {/if}

    </div>

    <p class="text-center hidden-print"><a href="clientarea.php">{$LANG.invoicesbacktoclientarea}</a></a></p>

</body>
</html>
