<table cellspacing=0 cellpadding=0 width=\"100%\">
  <tr valign=top>
    <td>
        <table with=\"100%\">
            <tr class=rowtitle>
              <td class=rowtitle colspan=2 align=center>#intranet-pmo.Budget# Plan</td>
            </tr>
            <tr>
                <td>#intranet-core.Project_Budget#</td>
                <td align=right>+ @project_budget;noquote@ @project_budget_currency;noquote@</td>
            </tr>
            <tr>
                <td>#intranet-pmo.Cost_Estimates#</td>
                <td align=right>- @cost_estimates;noquote@ @project_budget_currency;noquote@</td>
            </tr>
            <tr>
                <td><b>#intranet-pmo.Remaining_Budget#</b></td>
                <td align=right><b>@remaining_planned_budget;noquote@ @project_budget_currency;noquote@</b></td>
            </tr>
        </table>
    </td>
    <td>
        <table with=\"100%\">
            <tr class=rowtitle>
              <td class=rowtitle colspan=2 align=center>#intranet-pmo.Budget# Actual</td>
            </tr>
            <tr>
                <td>#intranet-core.Project_Budget#</td>
                <td align=right>+ @project_budget;noquote@ @project_budget_currency;noquote@</td>
            </tr>
            <tr>
                <td>#intranet-cost.Provider_Bills#</td>
                <td align=right>- @provider_bills;noquote@ @project_budget_currency;noquote@</td>
            </tr>
            <tr>
                <td><b>#intranet-pmo.Remaining_Budget#</b></td>
                <td align=right><b>@remaining_actual_budget;noquote@ @project_budget_currency;noquote@</b></td>
            </tr>
        </table>
    </td>    
  </tr>
</table>
<table>
  <tr valign=top>
    <td>
      <table with=\"100%\">
        <tr class=rowtitle>
        	  <td class=rowtitle colspan=2 align=center>#intranet-pmo.Hours# Budgeted</td>
        	</tr>
        	<tr>
        	  <td>#intranet-core.Project_Budget_Hours#</td>
        	  <td align=right> @project_budget_hours@</td>
        	</tr>
        	<tr>
        	  <td>#intranet-pmo.Budgeted_Hours#</td>
        	  <td align=right>- @budgeted_hours@</td>
        	</tr>
        	<tr>
        	  <td><b>#intranet-pmo.Remaining_Budget_Hours#</b></td>
        	  <td align=right><b>@remaining_budget_hours@</b></td>
        	</tr>	  
       </table>
    </td>    <td>
      <table with=\"100%\">
        <tr class=rowtitle>
              <td class=rowtitle colspan=2 align=center>#intranet-pmo.Hours# Planned</td>
            </tr>
            <tr>
              <td>#intranet-core.Project_Budget_Hours#</td>
              <td align=right> @project_budget_hours@</td>
            </tr>
            <tr>
              <td>#intranet-pmo.Planned_Hours#</td>
              <td align=right>- @planned@</td>
            </tr>
            <tr>
              <td><b>#intranet-pmo.Remaining_Planned_Hours#</b></td>
              <td align=right><b>@remaining_planned_hours@</b></td>
            </tr>	  
       </table>
    </td>
    <td>
        <table with=\"100%\">
         <tr class=rowtitle>
           <td class=rowtitle colspan=2 align=center>#intranet-pmo.Hours# Actual</td>
         </tr>
         <tr>
           <td>#intranet-core.Project_Budget_Hours#</td>
           <td align=right> @project_budget_hours@</td>
         </tr>
         <tr>
           <td>#intranet-pmo.Logged_Hours#</td>
           <td align=right>- @logged_hours_total@</td>
         </tr>
         <tr>
           <td>#intranet-pmo.Remaining_Hours#</td>
           <td align=right>- @remaining_hours@</td>
         </tr>
         <tr>
           <td><b>#intranet-pmo.Remaining_Budget_Hours#</b></td>
           <td align=right><b>@remaining_hours_total@</b></td>
         </tr>  
    </table>
    </td>
   </tr>    
</table>
