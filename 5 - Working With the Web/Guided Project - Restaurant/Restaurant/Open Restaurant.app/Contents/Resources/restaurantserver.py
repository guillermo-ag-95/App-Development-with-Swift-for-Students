from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import json
import copy

post_response_data = {"foo": "bar"}

class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    def do_GET(self):
        components = self.path.split('?')
        
        route = components[0]
        
        print(self.path)
        print(route)
        
        errorDict = {}

        if route == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
        
            self.wfile.write("""
                <html><body>
                <h1>Restaurant Server Running</h1>
                <p/>
                <h2>Categories</h2>
                <p>""" + categoriesLoadError + """</p>
                <h2>Menu Items</h2>
                <p>""" + menuItemsLoadError + """</p>
                </body></html>
                """)
        elif route == '/categories':
            self._set_headers()
            self.wfile.write(json.dumps({"categories": categories}))
        elif route == '/menu':
            self._set_headers()
            selectedItems = []
#             returnedDict = {"items": menuItems}
            
            if len(components) == 1:
                selectedItems = copy.deepcopy(menuItems)
            else:
                print(components[1])
                queryComponents = components[1].split('=')
                print(queryComponents)
                queryParam = queryComponents[0]
                queryValue = queryComponents[1]
                
                print(queryParam)
                print(queryValue)
                
                if queryParam == 'category':
                    if queryValue in categories:
                        for item in menuItems:
                            if item['category'] == queryValue:
                                selectedItems.append(item.copy())
                    else:
                        errorDict = {"error": "invalid category " + queryValue}
                else:
                    errorDict = {"error": "invalid query parameter " + queryParam}
            
            if len(errorDict) > 0:
                self.wfile.write(json.dumps(errorDict))
            else:
                returnedItems = []
                for item in selectedItems:
                    if 'estimated_prep_time' in item.keys():
                        del item['estimated_prep_time']
                    returnedItems.append(item)
                
                self.wfile.write(json.dumps({"items": returnedItems}))
        elif route.startswith('/images'):
            print("SENDING IMAGE")
            
            self.send_response(200)
            self.send_header('Content-Type', 'image/jpeg')
    #         self.send_header('Content-Length', str(len(returnedJSONString)))
            self.end_headers()
            
            imageFilePath = route[1:]
#             with open(imageFilePath, 'rb') as file:
#                 self.wfile.write(file)
            file = open(imageFilePath, 'rb')
            self.wfile.write(file.read())
            file.close
        else:
            self._set_headers()
            errorDict = {"error": "invalid route " + route}
            self.wfile.write(json.dumps(errorDict))
        
    def do_HEAD(self):
        self._set_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        print(body)
        jsonData = json.loads(body)
        print(jsonData)
        
        returnedJSON = {}
        
        prepTime = 0
        if "menuIds" in jsonData.keys():
            menuIds = jsonData['menuIds']
            ids_not_found = []
            for id in menuIds:
                if id in items_by_id.keys():
                    prepTime += items_by_id[id]['estimated_prep_time']
                else:
                    ids_not_found.append(id)
                    
            if len(ids_not_found) > 0:
                returnedJSON = {"error": "unexpected item ids in order: " + str(ids_not_found)[1:-1]}
            else:
                returnedJSON = {"preparation_time": prepTime}
        else:
            returnedJSON = {"error": "expected JSON dictionary key menuIds"}
        
        returnedJSONString = json.dumps(returnedJSON)
        
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
#         self.send_header('Content-Length', str(len(returnedJSONString)))
        self.end_headers()
        
        self.wfile.write(returnedJSONString) 
        return

categories = []
menuItems = []

categoriesLoadError = "Loaded successfully."
menuItemsLoadError = "Loaded successfully."
# def load_data():
with open("categories.json", 'r') as infile:
    try:
        categories = json.load(infile)
    except:
        categoriesLoadError = "Invalid JSON."
with open("menu.json", 'r') as infile:
    try:
        menuItems = json.load(infile)
    except:
        menuItemsLoadError = "Invalid JSON."

items_by_id = {}

for item in menuItems:
    item['image_url'] = 'http://localhost:8090/images/' + str(item['id']) + '.png'
    items_by_id[item['id']] = item

print(json.dumps(menuItems))

def run(server_class=HTTPServer, handler_class=S, port=8090):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting httpd...'
    httpd.serve_forever()

if __name__ == "__main__":
    from sys import argv

# load_data()

if len(argv) == 2:
    run(port=int(argv[1]))
else:
    run()
