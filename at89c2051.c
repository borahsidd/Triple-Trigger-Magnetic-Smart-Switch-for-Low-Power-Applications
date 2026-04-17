#include <reg51.h>

sbit hall=P1^7;
sbit ckt=P1^0;

int count=0;
int condition=0;
int state=0;
int x, a, b;


//////////////////////////////////Delay program
void delay(unsigned int msec)
{
  int i,j;
  for(i=0;i<msec;i++)
	{
  for(j=0;j<1275;j++);
	}
}
///////////////////////////////////////Main program
void main()
{
	hall=0;
	ckt=0;
  while(1)
  {
		if (condition==0)
		{
			if(hall==0 && count==0 && state==0)
			{
				count=count+1;
				ckt=0;
				state=1;
				delay(10);
			}
			else if(hall==1 && count==1 && state==1)
			{
				state=0;
				delay(10);
			}
			else if (hall==0 && count==1 && state==0)
			{
				count=count+1;
				ckt=0;
				state=1;
				delay(10);
			}
			else if(hall==1 && count==2 && state==1)
			{
				state=0;
				delay(10);
			}
			else if (hall==0 && count==2 && state==0)
			{
				count=count+1;
				ckt=0;
				state=1;
				delay(10);
			}
			else if(hall==1 && count==3 && state==1)
			{
				state=0;
				delay(10);
			}
			else if (hall==0 && count==3 && state==0)
			{
				count=count+1;
				ckt=1;
				count=0;
				condition=1;
				delay(10);
			}
			delay(100);
		}
		else if (condition==1)
		{
			if(hall==0 && count==0 && state==0)
			{
				count=count+1;
				ckt=1;
				state=1;
				delay(10);
			}
			else if(hall==1 && count==1 && state==1)
			{
				state=0;
				delay(10);
			}
			else if (hall==0 && count==1 && state==0)
			{
				count=count+1;
				ckt=1;
				state=1;
				delay(10);
			}
			else if(hall==1 && count==2 && state==1)
			{
				state=0;
				delay(10);
			}
			else if (hall==0 && count==2 && state==0)
			{
				count=count+1;
				ckt=1;
				state=1;
				delay(10);
			}
			else if(hall==1 && count==3 && state==1)
			{
				state=0;
				delay(10);
			}
			else if (hall==0 && count==3 && state==0)
			{
				count=count+1;
				ckt=0;
				count=0;
				condition=0;
				delay(10);
			}
			delay(100);
		}
  }
}