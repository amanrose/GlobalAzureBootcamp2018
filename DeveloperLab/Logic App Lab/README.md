
# Global Azure Bootcamp - Logic Apps Lab
## Check traffic with a scheduler-based Logic App

Azure Logic Apps helps you automate workflows that run on a schedule. This tutorial shows how you can build a logic app with a scheduler trigger that runs every weekday morning and checks the travel time, including traffic, between two places. If the time exceeds a specific limit, the logic app sends email with the travel time and the extra time necessary for your destination.

In this tutorial, you learn how to:
Create a blank logic app. 
* Add a trigger that works as a scheduler for your logic app.
* Add an action that gets the travel time for a route.
* Add an action that creates a variable, converts the travel time from seconds to minutes, and saves that result in the variable.
* Add a condition that compares the travel time against a specified limit.
* Add an action that sends email if the travel time exceeds the limit.

When you're done, your logic app looks like this workflow at a high level.

	![check-travel-time-overview](images/check-travel-time-overview.png)
	
### Prerequisites

* An email account form an email provider supported by Logic Apps, such as Office 365 Outlook, Outlook.com, or Gmail. See the full connector list [here](https://docs.microsoft.com/en-us/connectors/).
* To get the travel time for a route, you need an access key for the Bing Maps API.

### Sign into the Azure portal

Sign in to the [Azure Portal](https://portal.azure.com) with your Azure account credentials.

### Create your Logic App

1. From the main Azure menu, choose **Create a resource > Enterprise Integration > Logic App**.

	![create-logic-app](images/create-logic-app.png)

2. Under **Create logic app**, provide this information about your logic app as shown and described. When you're done, choose **Pin to dashboard > Create**.

	![create-logic-app-settings](images/create-logic-app-settingsp.png)

Setting		Value				Description
Name		LA-TravelTime			The name for your logic app
Subscription	<your-Azure-subscription-name>	The name for your Azure subscription
Resource group	LA-TravelTime-RG		The name for the Azure resource group used to organize related resources
Location	East US 2			The region where to store information about your logic app
Log Analytics	Off				Keep the Off setting for diagnostic logging.

3. After Azure deploys your app, the Logic Apps Designer opens and shows a page with an introduction video and templates for common logic app patterns. Under **Templates**, choose **Blank Logic App**.

	![choose-logic-app-template](images/choose-logic-app-template.png)


Next, add the recurrence trigger, which fires based on a specified schedule. Every logic app must start with a trigger, which fires when a specific event happens or when new data meets a specific condition.

### Add Scheduler Trigger

1. On the designer, enter "recurrence" in the search box. Select this trigger: Schedule - Recurrence

	![add-schedule-recurrence-trigger](images/add-schedule-recurrence-trigger.png)

2. On the **Recurrence** shape, choose the ellipses (...) button, and choose **Rename**. Rename the trigger with this description: "Check travel time every weekday morning".

	![rename-recurrence-schedule-trigger](images/rename-recurrence-schedule-trigger.png)

3. Inside the trigger, choose **Show advanced options**.

4. Provide the schedule and recurrence details for your trigger as shown and described:

	![schedule-recurrence-trigger-settings](images/schedule-recurrence-trigger-settings.png)
	![trigger-settings](images/trigger-settings)

This trigger fires every weekday, every 15 minutes, starting at 7:00 AM and ending at 9:45 AM. The Preview box shows the recurrence schedule. For more information, see [Schedule tasks and workflows](https://docs.microsoft.com/en-us/azure/connectors/connectors-native-recurrence) and [Workflow actions and triggers](https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-workflow-actions-triggers#recurrence-trigger).

5. To hide the trigger's details for now, click inside the shape's title bar.

	![collapse-trigger-shape](images/collapse-trigger-shape.png)

Your logic app is now live but doesn't do anything other recur. So, add an action that responds when the trigger fires.

### Get the travel time for a route

Now that you have a trigger, add an [action](https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-overview#logic-app-concepts) that gets the travel time between two places. Logic Apps provides a connector for the Bing Maps API so that you can easily get this information. Before you start this task, make sure that you have a Bing Maps API key as described in this tutorial's prerequisites.

1. In the Logic App Designer, under your trigger, choose **+ New step > Add an action**.

2. Search for "maps", and select this action: **Bing Maps - Get route**.

3. If you don't already have a Bing Maps connection, you're asked to create a connection. Provide these connection details, and choose **Create**.

	![create-maps-connection](images/create-maps-connection.png)
	![bing-connection-settings](images/bing-connection-settings.png)

4. Rename the action with this description: "Get route and travel time with traffic"

5. Provide details for the Get route action as shown and described here, for example:

	![get-route-action-settings](images/get-route-action-settings.png)
	![route-settings](images/route-settings.png)

6. Save your logic app.

Next, create a variable so that you can convert and store the current travel time as minutes, rather than seconds. That way, you can avoid repeating the conversion and use the value more easily in later steps. 

### Create variable to store travel time

Sometimes, you might want to perform operations on data in your workflow and use the results in later actions. To save these results so that you can easily reuse or reference them, you can create variables to store those results after processing them. You can create variables only at the top level in your logic app.

By default, the previous **Get route** action returns the current travel time with traffic in seconds through the **Travel Duration Traffic** field. By converting and storing this value as minutes instead, you make the value easier to reuse later without converting again.

1. Under the **Get route** action, choose **+ New step > Add an action**.

2. Search for "variables", and select this action: **Variables - Initialize variable**

	![select-initialize-variable-action](images/select-initialize-variable-action)

3. Rename this action with this description: "Create variable to store travel time"

4. Provide the details for your variable as described here:

	![travel-time-variable-settings](images/travel-time-variable-settings)

a. To create the expression for the Value field, click inside the field so that the dynamic content list appears. If necessary, widen your browser until the list appears. In the dynamic content list, choose Expression. 

	![initialize-variable-action-settings](images/initialize-variable-action-settings)

When you click inside some edit boxes, either a dynamic content list or an inline parameter list appears. This list shows any parameters from previous actions that you can use as inputs in your workflow. The dynamic content list has an expression editor where you can select functions for performing operations. This expression editor appears only in the dynamic content list.

Your browser width determines which list appears. If your browser is wide, the dynamic content list appears. If your browser is narrow, a parameter list appears inline under the edit box that currently has focus.

b. In the expression editor, enter this expression: div(,60)

	![initialize-variable-action-settings-2](images/initialize-variable-action-settings-2.png)

c. Put your cursor inside the expression between the left parenthesis (() and the comma (,). Choose **Dynamic content**.

	![initialize-variable-action-settings-3](images/initialize-variable-action-settings-3.png)

d. In the dynamic content list, select **Travel Duration Traffic**.

	![initialize-variable-action-settings-4](images/initialize-variable-action-settings-4.png)

e. After the field resolves inside the expression, choose **OK**.

	![initialize-variable-action-settings-5](images/initialize-variable-action-settings-5.png)

	The **Value** field now appears as shown here:

	![initialize-variable-action-settings-6](images/initialize-variable-action-settings-6.png)

5. Save your logic app.

Next, add a condition that checks whether the current travel time is greater than a specific limit.

### Compare travel time with limit

1. Under the previous action, choose **+ New step > Add a condition**. 

2. Rename the condition with this description: "If travel time exceeds limit"

3. Build a condition that checks whether **travelTime** exceeds your specified limit as described and shown here:

	a. Inside the condition, click inside the **Choose a value** box, which is on the left (wide browser view) or on top (narrow browser view).
	b. From either the dynamic content list or the parameter list, select the **travelTime** field under **Variables**.
	c. In the comparison box, select this operator: **is greater than**
	d. In the **Choose a value** box on the right (wide view) or bottom (narrow view), enter this limit: 15

	For example, if you're working in narrow view, here is how you build this condition:

	![build-condition-check-travel-time-narrow](images/build-condition-check-travel-time-narrow.png)

4. Save your logic app.

Next, add the action to perform when the travel time exceeds your limit.

### Send mail when limit is exceeded

Now, add an action that emails you when the travel time exceeds your limit. This email includes the current travel time and the extra time necessary to travel the specified route. 

1. In the condition's **If true** branch, choose **Add an action**.

2. Search for "send email", and select the email connector and the "send email action" that you want to use.

	![add-action-send-email](images/add-action-send-email.png)

	For personal Microsoft accounts, select Outlook.com. 
	For Azure work or school accounts, select Office 365 Outlook.

3. If you don't already have a connection, you're asked to sign in to your email account.
	Logic Apps creates a connection to your email account.

4. Rename the action with this description: "Send email with travel time"

5. In the **To** box, enter the recipient's email address. For testing purposes, use your email address.

6. In the **Subject** box, specify the email's subject, and include the **travelTime** variable.

	a. Enter the text "Current travel time (minutes):" with a trailing space. 
	
	b. From either the parameter list or the dynamic content list, select **travelTime** under **Variable**. 
	
	For example, if your browser is in narrow view:

	![send-email-subject-settings](images/send-email-subject-settings.png)

7. In the **Body** box, specify the content for the email body. 

	a. Enter the text "Add extra travel time (minutes):" with a trailing space. 
	
	b. If necessary, widen your browser until the dynamic content list appears. In the dynamic content list, choose **Expression**.

	![send-email-body-settings](images/send-email-body-settings.png)

	c. In the expression editor, enter this expression so that you can calculate the number of minutes that exceed your limit: sub(,15)

	![send-email-body-settings-2](images/send-email-body-settings-2.png)
	
	d. Put your cursor inside the expression between the left parenthesis (() and the comma (,). Choose **Dynamic content**.

	![send-email-body-settings-3](images/send-email-body-settings-3.png)

	e. Under **Variables**, select **travelTime**.

	![send-email-body-settings-4](images/send-email-body-settings-4.png)

	f. After the field resolves inside the expression, choose **OK**.

	![send-email-body-settings-5](images/send-email-body-settings-5.png)

	The Body field now appears as shown here:

	![send-email-body-settings-6](images/send-email-body-settings-6.png)

8. Save your logic app.

Next, test your logic app, which now looks similar to this example:

	![check-travel-time-finished](images/check-travel-time-finished.png)

### Run your logic app

To manually start your logic app, on the designer toolbar bar, choose **Run**. If the current travel time stays under your limit, your logic app does nothing else and waits for the next interval before checking again. But if the current travel time exceeds your limit, you get an email with the current travel time and the number of minutes above your limit. Here is an example email that your logic app sends:

	![email-notification](images/email-notification.png)

If you don't get any emails, check your email's junk folder. Your email junk filter might redirect these kinds of mails. 

Congratulations, you've now created and run a schedule-based recurring logic app. 

To create other logic apps that use the **Schedule - Recurrence** trigger, check out these templates, which available after you create a logic app:
	* Get daily reminders sent to you.
	* Delete older Azure blobs.
	* Add a message to an Azure Storage queue.

### Clean up resources

When no longer needed, delete the resource group that contains your logic app and related resources. On the main Azure menu, go to **Resource groups**, and select the resource group for your logic app. Choose **Delete resource group**. Enter the resource group name as confirmation, and choose **Delete**.

	![delete-resource-group](images/delete-resource-group.png)

Congratulations, you've completed this Logic App Lab! [Learn More about Logic Apps](https://docs.microsoft.com/en-us/azure/logic-apps/).
