void add() {
	Elem * newEl = new Elem;
	newEl -> info = i;
	if (start = NULL || newEl -> info <= start -> info)
	{
		newEl -> next = start;
		start = newEl;
	}
	else {
		Elem + tmp = start;
		while (tmp -> next != NULL && tmp -> next -> info < newEl -> info)
		{
			tmp = tmp -> next
		}
		newEl -> next = temp -> next;
		temp -> next = newEl;
	}
}

/*
1. Saraksts nav tukss
2. Ja dzēšs 1.
3. ja nav tada

// Add an element
Elem * newEl = new Elem;

*/


bool delEl(int i)
{
	if (start == NULL)
	{
		cout << "Saraksts ir tukšs!";
		return false;
	}
	else if (start -> next -> NULL)
	{
		cout << "Nevar dzēst vienīgo elementu!";
		return false;
	}
	else if ()
	{
		// No idea how to turn to a specific element
	}
	else
	{
		// Delete specific element
	}
}