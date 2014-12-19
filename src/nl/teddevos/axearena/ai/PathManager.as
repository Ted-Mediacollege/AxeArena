package nl.teddevos.axearena.ai 
{
	import flash.geom.Point;
	import nl.teddevos.axearena.util.MathHelper;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class PathManager extends Sprite
	{
		[Embed(source="../../../../../lib/level/path.xml", mimeType="application/octet-stream")]
		private var xmlfile:Class;
		
		public var NODES:Vector.<Node>;
		public var nodesLength:int;
		
		public function PathManager() 
		{
			var xmldata:XML = new XML(new xmlfile());
			nodesLength = xmldata.nodes.children().length();
			NODES = new Vector.<Node>(nodesLength);
			
			//var quadbatch:QuadBatch = new QuadBatch();
			//addChild(quadbatch);
			//var q:Quad = new Quad(20, 20, 0x00FF00);
			//q.pivotX = 10;
			//q.pivotY = 10;
			
			for (var i:int = 0; i < nodesLength; i++ )
			{
				var conLength:int = xmldata.nodes.node[i].children().length();
				var v:Vector.<Path> = new Vector.<Path>(conLength);
				for (var vl:int = 0; vl < conLength; vl++ )
				{
					v[vl] = new Path(xmldata.nodes.node[i].con[vl].@type, i, xmldata.nodes.node[i].con[vl]);
				}
				
				NODES[i] = new Node(v, xmldata.nodes.node[i].@x, xmldata.nodes.node[i].@y); 
				//q.x = NODES[i].x * 64;
				//q.y = NODES[i].y * 64;
				//quadbatch.addQuad(q);
			}
		}
		
		public function getClosestNode(posX:Number, posY:Number):int
		{
			var closestDistance:Number = Number.MAX_VALUE;
			var closestNode:int = 0;
			var dist:Number;
			
			for (var i:int = 0; i < nodesLength; i++ )
			{
				dist = MathHelper.dis2(posX / 64, posY / 64, NODES[i].x, NODES[i].y);
				if (dist < closestDistance)
				{
					closestDistance = dist;
					closestNode = i;
				}
			}
			return closestNode;
		}
		
		public function getPathFromTo(start:int, end:int):Vector.<int>
		{
			var nodes:Vector.<NodeCalc> = new Vector.<NodeCalc>();
			var routes:Vector.<PathCalc> = new Vector.<PathCalc>();
			
			for (var i:int = 0; i < NODES.length; i++ )
			{
				nodes.push(new NodeCalc(NODES[i].x, NODES[i].y, NODES[i].pathIds));
			}
			
			routes.push(new PathCalc(start, 0, new Vector.<int>));
			nodes[start].shortest = 0;
			
			var result:PathCalc;
			
			while (routes.length > 0)
			{
				for (var p:int = routes.length - 1; p > -1; p-- )
				{
					for (var c:int = 0; c < nodes[routes[p].currentNode].connections.length; c++)
					{
						var dis:Number = 1;// MathHelper.dis2(nodes[routes[p].currentNode].x, nodes[routes[p].currentNode].y, nodes[nodes[routes[p].currentNode].connections[c]].x, nodes[nodes[routes[p].currentNode].connections[c]].y)
						
						if (dis + routes[p].distance < nodes[nodes[routes[p].currentNode].connections[c]].shortest)
						{
							nodes[nodes[routes[p].currentNode].connections[c]].shortest = dis + routes[p].distance;
							var np:PathCalc = new PathCalc(nodes[routes[p].currentNode].connections[c], dis + routes[p].distance, routes[p].route.concat());
							routes.push(np);
							
							if (nodes[routes[p].currentNode].connections[c] == end)
							{
								result = np;
							}
						}
					}
					routes.splice(p, 1);
				}
			}
			
			if (result == null)
			{
				return new <int>[start, end];
			}
			
			return result.route;
		}
		
		public function getRandomNode():Point
		{
			var r:int = MathHelper.nextInt(nodesLength);
			return new Point(NODES[r].x, NODES[r].y);
		}
	}
}