#import "ArticlesVC.h"
#import "APIClient.h"
#import "ArticleVC.h"
#import "Article.h"

@implementation ArticlesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.articles = [[APIClient instance] articles];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
    // full length item delimiter hack
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

-(NSArray*)articles
{
    if (_articles == nil) {
        _articles = [[NSArray alloc]init];
    }
    return _articles;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    Article *article = self.articles [indexPath.row];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.text;
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: article.image]];
    cell.imageView.image = [UIImage imageWithData: imageData];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openArticle"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Article *article = [self.articles objectAtIndex:ip.row];
        [segue.destinationViewController setArticle:article.id];
    }
}

@end