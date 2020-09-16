package rich.controller;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@EnableAspectJAutoProxy
@ComponentScan(basePackages = { "rich.aop", "rich.controller", "rich.crawl", "rich.dao", "rich.notify"})
@Configuration
public class Config {

}
